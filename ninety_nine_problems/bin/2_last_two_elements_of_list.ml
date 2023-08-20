(*
  Find the last but one (last and penultimate) elements of a list
*)

let rec last_two list = 
  match list with
  | [] -> None
  | [x; y] -> Some (x, y)
  | _ :: tl -> last_two tl
;;
