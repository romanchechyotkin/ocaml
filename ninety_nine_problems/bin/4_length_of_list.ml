(*
  Find the number of elements of a list.
  OCaml standard library has List.length but we ask that you reimplement it. Bonus for a tail recursive solution.
*)

let length list = 
  let rec list_length list count = 
    match list with
    | [] -> count
    | _ :: tl -> list_length tl (count+1) 
  in
  list_length list 0  
;;

