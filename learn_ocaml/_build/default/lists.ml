open Printf;;

let languages = ["OCaml"; "Golang"; "C"; "Pascal"; "TypeScript"];;

let iterate_list (list: string list): unit = 
  let length = List.length list in
  for i = 0 to (length - 1) do
    let el = List.nth list i in
    Printf.printf "%s\n" el
  done;  
  Printf.printf "\n";;

let new_list = "American English" :: ["C++"; "Spanish"] @ languages;;  

iterate_list (new_list);;
iterate_list languages;;

let top_one (languages: string list): unit =
  match languages with
  | (top :: rest) -> Printf.printf "Top One: %s\n" top
  | [] -> Printf.printf "No favourite film\n"
;;

top_one languages;;
top_one new_list;;
top_one [];;


let rec sum (l: int list): int = 
  match l with
  | [] -> 0
  | (hd :: tl) -> hd + sum tl

let res = sum [1; 2; 3; 4];;
Printf.printf "%d\n" res;;

let rec remove_sequential_duplicates list =
  match list with
  | [] -> []
  | [x] -> [x]
  | first :: second :: tl ->
    if first = second then
      remove_sequential_duplicates (second :: tl)
    else
      first :: remove_sequential_duplicates (second :: tl);;      

let res = remove_sequential_duplicates([1;1;2;3;3;4;4;1;1;1]);;
let () = List.iter (printf "%d ") res


