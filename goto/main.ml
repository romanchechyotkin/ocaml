open Printf;;

exception Goto of string

let label (name: string) = ()
let goto (name: string) = raise (Goto name)

let () = 
  let i = ref 0 in
  try 
    label "loop";
    (fun () -> 
      if !i >= 10 then goto "out" else ();
      printf "%d hello world\n" !i;
      i := !i + 1;
      goto "loop";
    )
    label "out";
    (fun () -> 
      printf "done\n"
    )  
  with     
    Goto name -> 