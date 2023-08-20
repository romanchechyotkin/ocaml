(*
  Write a function last : 'a list -> 'a option that returns the last element of a list   
*)


type any_value = [ `Int of int | `String of string ]

let check_type x = 
  match x with
  | `String x -> Printf.printf "%s\n" x
  | `Int x -> Printf.printf "%d\n" x
;;

let rec last list =
  match list with
  | [] -> None 
  | [x] -> Some x
  | _ :: tail -> last tail
;;

let print_result (x: 'a option): unit = 
  match x with
  | None -> Printf.printf "none\n"
  | Some x -> check_type x
;;

print_result (last ["a"; "v"; "c"]);;
print_result (last[1; 2; 3]);;
print_result (last[1]);;
print_result (last[]);;


