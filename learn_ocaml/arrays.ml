type some_struct = {
  mutable numbers: int array;
  name: string;
}

let iterate_array (arr: int array) = 
  let n = Array.length arr in 
  match n with
    | 0 -> Printf.printf "empty numbers\n"  
    | _ ->
    for i = 0 to n -1 do
      Printf.printf "%d " arr.(i)
    done;
  Printf.printf "\n"
;;

let new_struct (name: string): some_struct = 
  let ss: some_struct = {
    name = name;
    numbers = [||];
  } in
  ss
;;

let print_struct (ss: some_struct) : unit = 
  Printf.printf "%s\n" ss.name;
  iterate_array ss.numbers
;;

let add_numbers (ss: some_struct) (args: int array): unit = 
  ss.numbers <- Array.append ss.numbers args;
  ()
;;

let my_struct = new_struct "Roman";;

print_struct my_struct;;

let nums = [| 1; 2; 3; 4 |] in
add_numbers my_struct nums;;
add_numbers my_struct [|5|];;

print_struct my_struct;;
