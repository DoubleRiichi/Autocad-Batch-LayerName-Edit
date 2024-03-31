 //---------------=={ Batch Attribute Editor }==---------------// 
                     //                                                            // 
                     //  batte.dcl dialog definition file to be used in            // 
                     //  conjunction with batte.lsp                                // 
                     //------------------------------------------------------------// 
                     //  Author: Lee Mac, Copyright © 2012 - www.lee-mac.com       // 
                     //------------------------------------------------------------// 
                      
                     //------------------------------------------------------------// 
                     //                  Sub-Assembly Definitions                  // 
                     //------------------------------------------------------------// 
          inputtest : dialog {
            

                     head : list_box 
                     { 
                         is_enabled = false; 
                         fixed_height = true; 
                         fixed_width = true; 
                         height = 2; 
                         vertical_margin = none; 
                         horizontal_margin = none; 
                     } 
                      
                     txt : text     { vertical_margin = none; } 
                     edt : edit_box { vertical_margin = 0.1; edit_limit = 1024; } 
                      
                     but1 : button 
                     { 
                         fixed_width = true; 
                         fixed_height = true; 
                         width = 20; 
                         height = 1.8; 
                         alignment = centered; 
                     } 
                      
                     but2 : button 
                     { 
                         fixed_width = true; 
                         fixed_height = true; 
                         width = 15; 
                         height = 1.8; 
                     } 
                      
                     but3 : button 
                     { 
                         fixed_width = true; 
                         fixed_height = true; 
                         width = 18; 
                         height = 2.2; 
                     } 
                      
                     but4 : button 
                     { 
                         fixed_width = true; 
                         fixed_height = true; 
                         width = 10; 
                         height = 1.0; 
                     } 
                      
                     dwgbox : list_box 
                     { 
                         width = 40; 
                         height = 24; 
                         fixed_width = true; 
                         fixed_height = true; 
                         alignment = centered; 
                         multiple_select = true; 
                         vertical_margin = none; 
                         tab_truncate = true; 
                     } 
                      
                     tagbox : list_box 
                     { 
                         width = 80; 
                         height = 19; 
                         fixed_height = true; 
                         fixed_width = true; 
                         tabs = "22 44"; 
                         vertical_margin = none; 
                         horizontal_margin = none; 
                         multiple_select = true; 
                         tab_truncate = true; 
                     } 
                      
                     editbox : edit_box 
                     { 
                         width = 65; 
                         fixed_width = true; 
                         edit_limit = 1024; 
                     } 
                      
                     edittxt : text 
                     { 
                         alignment = right; 
                     } 
                      
                     spacer0 : spacer 
                     { 
                         width = 0.1; 
                         height = 0.1; 
                         fixed_width = true; 
                         fixed_height = true; 
                     } 
                      
                     //------------------------------------------------------------// 
                     //                    Edit Dialog Definition                  // 
                     //------------------------------------------------------------// 
                      
                     edit : dialog 
                     { 
                         initial_focus = "block"; 
                         label = "Edit Item" ; 
                         spacer; 
                         : row 
                         { 
                             : column 
                             { 
                                 spacer0; 
                                 : edittxt { label = "Block:"; } 
                                 spacer0; 
                             } 
                             : editbox { key = "block"; } 
                         } 
                         : row 
                         { 
                             : column 
                             { 
                                 spacer0; 
                                 : edittxt { label = "Tag:"; } 
                                 spacer0; 
                             } 
                             : editbox { key = "tag" ; } 
                         } 
                         : row 
                         { 
                             : column 
                             { 
                                 spacer0; 
                                 : edittxt { label = "Value:"; } 
                                 spacer0; 
                             } 
                             : editbox { key = "value"; } 
                         } 
                         spacer_1; 
                         ok_cancel; 
                     } 
                      
                     //------------------------------------------------------------// 
                     //                Block Selection Dialog Definition           // 
                     //------------------------------------------------------------// 
                      
                     select : dialog 
                     { 
                         label = "Select Items to Add"; 
                         spacer_1; 
                         : row 
                         { 
                             fixed_width = true; 
                             alignment = left; 
                             spacer; 
                             : text { label = "Select items to add to the attribute data list:"; } 
                         } 
                         spacer; 
                         : row 
                         { 
                             spacer; 
                             : head { key = "h1"; width = 22; tabs = "8"; } 
                             : head { key = "h2"; width = 22; tabs = "8"; } 
                             : head { key = "h3"; width = 36; tabs = "15";} 
                             spacer; 
                         } 
                         : row 
                         { 
                             spacer; 
                             : tagbox { key = "list"; } 
                             spacer; 
                         } 
                         : row 
                         { 
                             fixed_width = true; 
                             alignment = left; 
                             spacer; 
                             : toggle { label = "Select All"; key = "all"; } 
                         } 
                         ok_cancel; 
                     } 
                      
                     //------------------------------------------------------------// 
                     //                    Main Dialog Definition                  // 
                     //------------------------------------------------------------// 
                      
                     //------------------------------------------------------------// 
                     //                          Screen 1                          // 
                     //------------------------------------------------------------// 
                      
                     batte1 : dialog 
                     { 
                         initial_focus = "block"; 
                         key = "dcltitle"; 
                         spacer; 
                         : text { alignment = right; label = ""; } 
                         : boxed_column 
                         { 
                             label = "Attribute Data"; 
                             : column 
                             { 
                                 : row 
                                 { 
                                     : column 
                                     { 
                                         : txt { label = "Block Name"; } 
                                         : edt { key = "block"; } 
                                     } 
                                     : column 
                                     { 
                                         : txt { label = "Attribute Tag"; } 
                                         : edt { key = "tag"; } 
                                     } 
                                     : column 
                                     { 
                                         : txt { label = "Attribute Value"; } 
                                         : edt { key = "value"; } 
                                     } 
                                 } 
                                 spacer; 
                             } 
                             spacer; 
                             : row 
                             { 
                                 fixed_width = true; 
                                 alignment = centered; 
                                 : but1 { key = "additem"; label = "&Add Item"; mnemonic = "A"; } 
                                 spacer; 
                                 : but2 { key = "select";  label = "Select &Blocks..."; mnemonic = "B"; } 
                                 spacer; 
                                 : but1 { key = "delitem"; label = "&Remove Item"; mnemonic = "R"; } 
                             } 
                             spacer; 
                             : row 
                             { 
                                 fixed_width = true; 
                                 alignment = left; 
                                 spacer; 
                                 : text { label = "Double-click to edit item"; } 
                             } 
                             : row 
                             { 
                                 spacer; 
                                 : head { key = "h1"; width = 22; tabs = "8"; } 
                                 : head { key = "h2"; width = 22; tabs = "8"; } 
                                 : head { key = "h3"; width = 36; tabs = "15";} 
                                 spacer; 
                             } 
                             : row 
                             { 
                                 spacer; 
                                 : tagbox { key = "list"; } 
                                 spacer; 
                             } 
                             : row 
                             { 
                                 fixed_width = true; 
                                 alignment = centered; 
                                 : but1 { key = "load"; label = "&Load from File"; mnemonic = "L"; } 
                                 spacer; 
                                 : but2 { key = "clear"; label = "&Clear"; mnemonic = "C"; } 
                                 spacer; 
                                 : but1 { key = "save"; label = "&Save to File"; mnemonic = "S"; } 
                             } 
                             spacer; 
                         } 
                         spacer; 
                         : row 
                         { 
                             fixed_width = true; 
                             alignment = centered; 
                             : but3 { key = "accept"; is_default = true; label = "&Next"; mnemonic = "N"; } 
                             spacer_1; 
                             : but3 { key = "cancel"; is_cancel = true; label = "&Exit"; mnemonic = "E"; } 
                         } 
                     } 
                      

                     batte2 : dialog 
                     { 
                         key = "dcltitle"; 
                         spacer; 
                         : text { alignment = right; label = ""; } 
                         : boxed_column 
                         { 
                             label = "Drawings to Process"; 
                             : column 
                             { 
                                 : txt { label = "Folder"; } 
                                 : row 
                                 { 
                                     : edt { key = "directory"; } 
                                     : button { key = "browse"; label = "&Browse"; mnemonic = "B"; fixed_width = true; } 
                                 } 
                             } 
                             spacer_1; 
                             : row 
                             { 
                                 : column 
                                 { 
                                     fixed_width = true; 
                                     alignment = centered; 
                                     : dwgbox { key = "box1"; } 
                                     : but1   { key = "add"; label = "&Add Files"; mnemonic = "A"; } 
                                     spacer; 
                                 } 
                                 : column 
                                 { 
                                     fixed_width = true; 
                                     fixed_height = true; 
                                     alignment = centered; 
                                     : but4   { key = "top";    label = "&Top";    mnemonic = "T"; } 
                                     : but4   { key = "up";     label = "&Up";     mnemonic = "U"; } 
                                     : but4   { key = "down";   label = "&Down";   mnemonic = "D"; } 
                                     : but4   { key = "bottom"; label = "B&ottom"; mnemonic = "O"; } 
                                     : but4   { key = "sort";   label = "&Sort";   mnemonic = "S"; } 
                                     : spacer 
                                     { 
                                         height = 1.8; 
                                         fixed_height = true; 
                                     } 
                                     spacer; 
                                 } 
                                 : column 
                                 { 
                                     fixed_width = true; 
                                     alignment = centered; 
                                     : dwgbox { key = "box2"; } 
                                     : but1   { key = "del"; label = "Remove &Files"; mnemonic = "F"; } 
                                     spacer; 
                                 } 
                             } 
                         } 
                         spacer; 
                         : row 
                         { 
                             fixed_width = true; 
                             alignment = centered; 
                             : but3 { key = "back"; label = "Ba&ck"; mnemonic = "c"; } 
                             spacer_1; 
                             : but3 { key = "accept"; is_default = true; label = "&Run"; mnemonic = "R"; } 
                             spacer_1; 
                             : but3 { key = "cancel"; is_cancel = true; label = "&Exit"; mnemonic = "E"; } 
                         } 
                     } 
          }