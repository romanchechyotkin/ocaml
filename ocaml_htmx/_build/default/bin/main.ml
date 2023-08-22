open Lwt.Syntax;;

let elt_to_string elt = Fmt.str "%a" (Tyxml.Html.pp_elt()) elt;;

type todo = {
  id: int;
  title: string;
  mutable is_done: bool; 
}

let storage: todo list ref = ref [];;

let is_completed is_done = 
  match is_done with
  | true -> "line-through"
  | false -> ""
;;

let display_row row = 
  let open Tyxml.Html in 
  let ocaml = li ~a:[ 
    a_class ["flex"; "gap-1"; "w-fit"];
    a_id (Printf.sprintf "todo%d" row.id);
    Unsafe.string_attrib "hx-target" "this"; 
    Unsafe.string_attrib "hx-swap" "outerHTML"; 
  ]
  [
    div ~a:[ 
      a_class ["flex"; "gap-1"; "w-fit"; is_completed row.is_done]; 
      Unsafe.string_attrib "hx-post" (Printf.sprintf "/update/%d" row.id);
      Unsafe.string_attrib "hx-trigger" "click"; 
    ] 
    [
      div [ txt (Int.to_string row.id) ]; 
      div [ txt (row.title) ]; 
      div [ txt (Bool.to_string row.is_done) ]; 
    ];
    button ~a:[ 
      a_class ["border-black"];
      Unsafe.string_attrib "hx-target" (Printf.sprintf "#todo%d" row.id); 
      Unsafe.string_attrib "hx-swap" "delete"; 
      Unsafe.string_attrib "hx-post" (Printf.sprintf "/delete/%d" row.id);
      Unsafe.string_attrib "hx-trigger" "click"; 
    ] 
    [ 
      txt "delete" 
    ]
  ] in 
  ocaml
;;

let display_storage storage = 
  let open Tyxml.Html in 
  let ocaml = ul ~a:[a_class ["list"]; a_id "list" ] (List.map (display_row) storage) in
  ocaml
;;

let create_form () = 
  let open Tyxml.Html in
  let ocaml = input() ~a:[ 
    a_placeholder "name"; 
    a_input_type `Text; 
    a_name "input";
    Unsafe.string_attrib "hx-post" "/create";
    Unsafe.string_attrib "hx-trigger" "click[ctrlKey]"; 
    Unsafe.string_attrib "hx-target" "#list"; 
    Unsafe.string_attrib "hx-swap" "beforeend"; 
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

let change_is_done t = 
  t.is_done <- true
;;

let complete_todo id =
  let t = List.find (fun t -> t.id = id) !storage in
  change_is_done t;
  display_row t
;;

let delete_todo id =
  storage := List.filter (fun t -> t.id != id) !storage
;;

let index storage = 
  let open Tyxml.Html in 
  let ocaml = html ~a:[a_class ["p-3.5"] ] (
    head 
      (title (txt "ocaml"))
      [ 
        script ~a:[a_src "https://unpkg.com/htmx.org@1.9.4"] (txt "");
        script ~a:[a_src "https://cdn.tailwindcss.com"] (txt "") 
      ]
      ) 
    (body 
    [
      create_form();
      display_storage storage;
    ])
  in
  ocaml
;;

let main () =
  Dream.run ~port: 22869
  @@ Dream.logger
  @@ Dream.router [

    Dream.get "/" (fun _ -> 
      (
        Dream.html @@ elt_to_string (index (List.rev !storage))
      ));

    Dream.post "/create" (fun request -> 
      let* name = Dream.form ~csrf:false request in
      match name with
      | `Ok ["input", value] ->
        Dream.html @@ elt_to_string (create_todo value)
      | _ -> Dream.empty `Bad_Request
    );

    Dream.post "/update/:id" (fun request -> 
      let id = Dream.param request "id" in
      Dream.html @@ elt_to_string (complete_todo (int_of_string id))
    );

    Dream.post "/delete/:id" (fun request -> 
      let id = Dream.param request "id" in
      delete_todo (int_of_string id);
      Dream.empty `OK
    )

  ]
;;

main ()
