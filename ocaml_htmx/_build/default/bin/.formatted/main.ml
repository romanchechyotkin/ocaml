open Lwt.Syntax
open Tyxml.Html

type todo = { id : int; title : string; is_done : bool }

(*
   let elt_to_string elt = Fmt.str "%a" (Tyxml.Html.pp_elt()) elt;;


   let storage = ref [];;

   let render_hello _ =
     (* let ul_children = [li [txt "1st"]; li [txt "2nd"]; li [txt "3rd"]; li [ a ~a:[ a_href "https://www.ocaml.org" ] [txt "ocaml"] ] ] in     *)
     let ocaml =
       div ~a:[a_class ["foo"]; a_style "color:red" ]
       [
         h1 [ txt "OCaml HTMX" ];
       ]
     in
     Dream.html @@ elt_to_string ocaml
   ;;

   let responde request =
     let* body = Dream.body request in
     Dream.respond ~headers:["Content-Type", "application/octet-stream"] body

   let main () =
     Dream.run ~port: 22869
     @@ Dream.logger
     @@ Dream.router [

       Dream.get "/" (fun _ -> render_hello());

       Dream.post "/storage" (fun request -> responde request);

     ];;

   main ();; *)
