; TODO: WORKING-DIR est un peu inutile, (getvar "DWGPREFIX") accompli la même chose.
(setq  APP-PATH         "")
(load (strcat APP-PATH  "/src/TEXT/textUtils.lsp"))
(load (strcat APP-PATH  "/src/ERROR-HANDLING/termination.lsp"))
(load (strcat APP-PATH  "/src/ERROR-HANDLING/logging.lsp"))

(setq   DOCUMENTS-DIR   (vl-string-translate "\\" "/" (strcat (getenv "UserProfile") "/Documents/"))
        DWG-DIR         (vl-string-translate "\\" "/" (getvar "DWGPREFIX"))
        DWG-NAME        (getvar "DWGNAME")
        DATA-FILE-PATH  (strcat DOCUMENTS-DIR "edition-calque-data.txt")
        LAST-FILE-PATH  (strcat DOCUMENTS-DIR "last_file.txt")
        UTILS-FILE-LIST (list DATA-FILE-PATH LAST-FILE-PATH))


;on ouvre le fichier txt préalablement crée pour en récupérer :
(setq layers_values (list ))
(setq data_file    (open DATA-FILE-PATH "r"))
(setq WORKING-DIR (read-line data_file))

(while (setq line (read-line data_file))
  (print line)
  (setq layers_values (append layers_values (list line))))

(close data_file)
(setq OUTPUT-DIR (strcat WORKING-DIR "RESULTAT/"))
;[/INIT]


(defun replaceValue (/ success)
  (setq success nil)
  
  (vlax-for object
   (vla-get-layers
     (vla-get-activedocument (vlax-get-acad-object)))
    
    (setq layer (vla-get-name object))
    (setq renamed_layer nil)
    
    (foreach line layers_values
      (setq split_line (splitLine line))
      (setq old_value  (car split_line))
      (setq new_value  (car (cdr split_line)))
      
      ;(if (numberp old_value)
        ;(setq old_value (itoa old_value)))
    
      (if (= old_value layer)
        (setq renamed_layer (vl-string-subst new_value old_value layer))))
            
    (if (and renamed_layer 
            (not (tblsearch "LAYER" renamed_layer)))
      (progn
        (vl-catch-all-apply 'vla-put-name (list object renamed_layer))
        (setq success t)))
    
    (logAdd OUTPUT-DIR (strcat "|> " layer " -> " (vla-get-name object))))
    success
)




(defun saveDWG (/ success)
  
    (setq thisdrawing (vla-get-activedocument (vlax-get-acad-object)))
  
    (setq drawing_path (strcat OUTPUT-DIR (vl-string-subst "" WORKING-DIR DWG-DIR) DWG-NAME)) ; à factoriser, probablement redondant
    (print drawing_path)
    (vla-SaveAs thisdrawing drawing_path)
)


(defun WORKER ()

    (if (vl-string-search WORKING-DIR DWG-DIR)
        (progn
          (logAdd OUTPUT-DIR (strcat "Travaille sur : " DWG-NAME))
          
          (setq replacedp (replaceValue))
          
          (if replacedp
            (saveDWG))
          
          (logAdd OUTPUT-DIR (strcat "Fermeture : " DWG-NAME))
          (logEmptyLine OUTPUT-DIR)
          
          ; Le fichier ouvert dans last_file ne contient qu'une seule ligne indiquant la valeur au dernier index
          ; de la liste de fichiers .DWG à éditer construite dans main.lsp, on détermine si le dessin actuel est le dernier
          ; et on se prépare à terminer les programme en nettoyant les fichiers temporaires.
          ; (setq WORKER NIL) permet de s'assurer que worker.lsp ne s'execute pas automatiquement lorsqu'on ouvre de nouveau dessins dans la même session.
          ; cf-> (vla-load-all "worker.lsp") 
          (if (setq last_file (open LAST-FILE-PATH "r"))
              (progn
                (setq last_file_value (read-line last_file))
                
                (if (=  last_file_value (strcat DWG-DIR DWG-NAME))
                  (progn
                    (close last_file)
                    (terminate)
                    (setq WORKER nil)))
            
                (close last_file)))
          
          (command "FERMER" "n")
          (princ)))
)

(WORKER)