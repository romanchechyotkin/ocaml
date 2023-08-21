open Lwt.Syntax;;

let elt_to_string elt = Fmt.str "%a" (Tyxml.Html.pp_elt()) elt;;

type todo = {
  id: int;
  title: string;
  is_done: bool; 
}

let storage: todo list ref = ref [
];;

let display_row row = 
  let open Tyxml.Html in 
  let ocaml = li ~a:[a_class ["flex"; "gap-1"] ] [
    div [ txt (Int.to_string row.id) ]; 
    div [ txt (row.title) ]; 
    div [ txt (Bool.to_string row.is_done) ]; 
  ] in 
  ocaml
;;

let display_storage list = 
  let open Tyxml.Html in 
  let ocaml = ul ~a:[a_class ["list"]; a_id "list" ] (List.map (display_row) list) in
  ocaml
;;

let create_form () = 
  let open Tyxml.Html in
  let ocaml = div ~a:[] [ 
    input() ~a:[ 
      a_placeholder "name"; 
      a_input_type `Text; 
      a_name "input";
      Unsafe.string_attrib "hx-post" "/create";
      Unsafe.string_attrib "hx-trigger" "click[ctrlKey]"; 
      Unsafe.string_attrib "hx-target" "#list"; 
      Unsafe.string_attrib "hx-swap" "beforeend"; 
    ];  
  ] in
  ocaml
;;

let create_todo (name: string) = 
  let t: todo = {
    id = List.length !storage;
    title = name;  
    is_done = false;
  } in
  storage := t :: !storage; 
  display_row t
;;

let index = 
  let open Tyxml.Html in 
  let ocaml = html ~a:[a_class ["p-3.5"] ] (
    head 
      (title (txt "ocaml"))
      [ 
        script ~a:[a_src "https://unpkg.com/htmx.org@1.9.4" ] (txt "");
        script ~a:[a_src "https://cdn.tailwindcss.com" ] (txt "") 
      ]
      ) 
    (body 
    [
      create_form();
      display_storage !storage
    ] )
  in
  ocaml
;;

let main () =
  Dream.run ~port: 22869
  @@ Dream.logger
  @@ Dream.router [

    Dream.get "/" (fun _ -> (Dream.html @@ elt_to_string index));

    Dream.post "/create" (fun request -> 
      let* name = Dream.form ~csrf:false request in
      match name with
      | `Ok ["input", value] ->
        Dream.html @@ elt_to_string (create_todo value)
      | _ -> Dream.empty `Bad_Request
    )

  ]
;;

main ()
