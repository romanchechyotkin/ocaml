(*
  Find the N'th element of a list.
  Remark: OCaml has List.nth which numbers elements from 0 and raises an exception if the index is out of bounds.
*)

exception Out_of_range of string  

let rec position (list: 'a list) (pos: int) = 
  match list with
  | []-> None
  | hd :: tl -> if pos = 0 then Some hd else position tl (pos-1)
;;
