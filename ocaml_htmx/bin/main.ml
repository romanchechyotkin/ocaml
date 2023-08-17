open Printf;;
open Tyxml.Html;;

type todo = {
  id: int;
  title: string;
  is_done: bool; 
}

let storage: todo list ref = ref [];;

let elt_to_string elt = Fmt.str "%a" (Tyxml.Html.pp_elt()) elt;;

let create_todo (title: string) = 
  let todo: todo = {title; is_done = false; id = List.length !storage} in
  storage := todo :: !storage;
  let ocaml = 
    div ~a:[ a_class [ "todo" ] ] 
    [
      span [txt (sprintf "%d" todo.id) ];
      span [txt (sprintf "%s" todo.title) ];
      span [txt (sprintf "%b" todo.is_done) ];
    ] in
  Dream.html @@ elt_to_string ocaml
;;

(* let update_todo (id: int) = 
  let open Base in
  match List.find !storage ~f:(fun t -> t.id = id) with
    | Some todo -> todo.is_done <- true
    | None -> ()
;;
 *)
(* 
 let render_todos = 
  let ocaml = List.map !storage ~f:() in
  Dream.html @@ elt_to_string ocaml
;; *)

(* 
let responde request = 
  let* body = Dream.body request in
  Dream.respond ~headers:["Content-Type", "application/octet-stream"] body;; *)


let main () =
  Dream.run ~port: 22869
  @@ Dream.logger
  @@ Dream.router [

    Dream.get "/" (Dream.from_filesystem "static" "index.html");
    (* Dream.get "/todo" (fun _ -> render_todos); *)
    Dream.post "/todo" (fun request -> 
      let%lwt form = Dream.form request in
      match form with
      | `Ok ["title", title] -> create_todo title
      | _ -> Dream.empty `Bad_Request
    );

  ]
;;

main ()