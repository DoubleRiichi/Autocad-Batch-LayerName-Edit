(vl-load-com)
(setq APP-PATH "") ; à changer
(load (strcat APP-PATH  "/src/FILE/fileUtils.lsp"))
(load (strcat APP-PATH  "/src/FILE/BrowseForFolderV1-3.lsp"))
(load (strcat APP-PATH  "/src/TEXT/textUtils.lsp"))
(load (strcat APP-PATH  "/src/ERROR-HANDLING/logging.lsp"))

(setq DOCUMENTS-DIR   (vl-string-translate "\\" "/" (strcat (getenv "UserProfile") "/Documents/")))
(setq DATA-FILE-PATH  (strcat DOCUMENTS-DIR "edition-calque-data.txt")
      LAST-FILE-PATH  (strcat DOCUMENTS-DIR  "last_file.txt"))


(defun createDataFile (values_list working_dir /)
    
    (setq data_file (open DATA-FILE-PATH "w"))
    (write-line working_dir data_file)
  
    (foreach elem values_list
      (write-line (strcat (car elem) "$£$" (car (cdr elem))) data_file))
  
    (close data_file)

)


(defun createLastFile (filename /)
  
    (setq last_file (open LAST-FILE-PATH "w"))
    (write-line filename last_file)
    (close last_file)
)



(defun setupTask ( / file_list)

    (setq working_dir (getPath 
                        (browseforfolder "Selectionnez le dossier contenant les grilles dont les calques doivent être changés." ; fileUtils.lsp
                          (vl-string-translate "\\" "/" (getenv "UserProfile")) 0)) 
          file_list   (getFilesInPath working_dir "RESULTAT")
          output_dir  (strcat working_dir "RESULTAT/"))
    
    (setq values (layerEdit)) ; defini dans inpubox.lsp
    (print output_dir)
    ; création d'un fichier temporaire permettant à worker.lsp de savoir quoi faire
    (createDatafile values working_dir)
    
    (if (null (vl-file-directory-p output_dir))
      (vl-mkdir output_dir))
    
    ; recrée les sous-dossiers du dossier courant dans celui des Résultats, pour conserver la structure
    (makeResultFolderStruct (getFoldersInPath working_dir "RESULTAT" "RESULTAT/"))
    (createLogFile  output_dir)
 

    ;(logUserValues  output_dir old_value new_value)
    
    file_list
) 


(defun c:EditionCalques ()

  (if (setq file_list (setupTask)) ;TRY
      (progn  
        (createLastFile (nth (1- (length file_list)) file_list))
        (vl-load-all (strcat APP-PATH "/worker.lsp")) 
        ; à partir de maintenant, worker.lsp sera chargé dans CHAQUE dessin actif ou ouvert pendant la session
        ; cependant mettre le gros de worker.lsp dans une fonction WORKER et évaluer (setq WORKER NIL) à la fin du programme termine ce comportement
        
        (foreach filename file_list
            
            (openDWG filename))))
)