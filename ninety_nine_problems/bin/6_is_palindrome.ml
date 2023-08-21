let rec reverse (list: 'a list) (out: 'a list) = 
  match list with
  | [] -> out
  | hd :: tl -> reverse tl (hd :: out)  
;;

let rev list = 
  reverse list []
;;

let is_palindrome list =
  let check_list = rev list in
  list = check_list
;; 
