type point2d = {x: float; y: float};;
let p: point2d = {x = 1.; y = 1.};;
let magnitude { x = x_pos; y = y_pos} = 
  Float.sqrt(x_pos ** 2. +. y_pos ** 2.);;
magnitude p 


type todo = {
  description: string;
  mutable is_done: bool;
  id: int;
}
let storage : todo list ref = ref [];; 

let create_todo (descr: string): int = 
  let t = {description = descr; is_done = false; id = List.length !storage} in
  storage := t :: !storage;
  t.id
;;

let finish_todo (id: int) = 
  let open Base in
  match List.find !storage ~f:(fun t -> t.id = id) with
  | Some todo -> 
    todo.is_done <- true;
    Some todo
  | None -> None
;;

let print_todo (t: todo): unit = 
  Printf.printf "%d %s %b\n" t.id t.description t.is_done

let t1 = create_todo "drop the trash";;
let t2 = create_todo "read docs";;
let t3 = create_todo "take a bath";;
let t4 = create_todo "finish task";;

List.iter print_todo !storage;;

finish_todo t1;;
finish_todo t3;;

Printf.printf "\n";;

List.iter print_todo !storage;;
