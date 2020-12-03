let () = print_endline "Expenses: under construction"

(* open Core *)
(* open Lexing *)
(* open Parsing.Lexer
open Parsing.Parser *)

let path_concat path1 path2 = path1 ^ "/" ^ path2

let get_date () = Unix.time () |> Unix.gmtime |> Core.Date.of_tm

(* TODO: make configurable *)
let cwd =
  String.concat "/" [""; "home"; "isaac"; "Documents"; "Quantifier"; "Purchases"]

let try_stat f = try Some (Unix.stat f) with Unix.Unix_error _ -> None

let is_stats_dir (s : Unix.stats) = s.st_kind = Unix.S_DIR

let is_stats_file (s : Unix.stats) = s.st_kind = Unix.S_REG

let is_dir path =
  try_stat path |> Core.Option.value_map ~default:false ~f:is_stats_dir

let is_file path =
  try_stat path |> Core.Option.value_map ~default:false ~f:is_stats_file

let get_or_create_dir () =
  let yr = get_date () |> Core.Date.year |> string_of_int in
  let dpath = path_concat cwd yr in
  print_endline dpath ;
  if is_dir dpath then dpath
  else (
    Unix.mkdir dpath 493 ;
    dpath )

let get_or_create_file fpath =
  if is_file fpath then Expenses.Io.load_and_convert fpath else ()

(* open & parse csv file on path *)

(*
let check_date () =
  let open Core.Out_channel in
  let open Core.In_channel in
  match 


let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf
    outx
    "%s:%d:%d"
    pos.pos_fname
    pos.pos_lnum
    (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf =
  try expense read lexbuf with
  | SyntaxError msg ->
      fprintf stderr "%a: %s\n" print_position lexbuf msg ;
      None
  | Error ->
      fprintf stderr "%a: syntax error\n" print_position lexbuf ;
      exit (-1)

(* parse and check derivation *)
let parse_and_check lexbuf =
  match parse_with_error lexbuf with
  | Some value -> string_of_bool value |> print_endline
  | None -> ()

(* handler function *)
let handler f () =
  let open In_channel in
  match f with
  | None -> ()
  | Some filename ->
      let inx = create filename in
      let lexbuf = Lexing.from_channel inx in
      lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename } ;
      parse_and_apply lexbuf ;
      close inx

(* cli *)
let () =
  Command.basic_spec
    ~summary:"Parse, display, and prove derivations"
    Command.Spec.(
      empty +> flag "-p" (optional string) ~doc:" Prove the derivation")
    handler
  |> Command.run *)
