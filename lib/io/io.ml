open Expense_types

module ItemMap = Map.Make(String)
type expense_map = Expense.t ItemMap.t

let date_opt_of_assoc = function
| "Date", "" -> None
| "Date", d -> Some (Date.of_string d)
| _ -> assert false

let price_opt_of_assoc = function
| "Amount", "" -> None
| "Amount", p -> Some (Price.of_string p)
| _ -> assert false

let vendor_of_assoc = function
| "Who", v -> v
| _ -> assert false

let what_of_assoc = function
| "What", w -> w
| _ -> assert false

let pmt_opt_of_assoc = function
| "Payment method", "" -> None
| "Payment method", p -> Some (Payment_method.of_string p)
| _ -> assert false

(** converts a 5-element string * string assoc list into an expense *)
let expense_of_alist = function
| [d; a; v; w; p] ->
    Expense.mk_expense ~date:(date_opt_of_assoc d) ~amount:(price_opt_of_assoc a)
      ~vendor:(vendor_of_assoc v) ~what:(what_of_assoc w)
      ~payment_method:(pmt_opt_of_assoc p)
| _ -> assert false

let remove_empty_total =
  List.filter (
    let open Core.Poly in
    let empty =
      ["Date", ""; "Amount", ""; "Who", ""; "What", ""; "Payment method", ""]
    in
    fun l -> l <>  empty && List.hd l <> ("Date", "Total"))

let csv_template =
  let header = ["Date"; "Amount"; "Who"; "What"; "Payment method"] in
  let blank = [""; ""; ""; ""; ""] in
  let body = ["Total"; ""; ""; ""; ""] in
  header :: blank :: [body]

let append _csv _row = ()

let csv_of_associated alist =
  let header = List.hd (List.map (fun l -> List.map (fun (h, _) -> h) l) alist) in
  let body = List.tl (List.map (fun l -> List.map (fun (_, x) -> x) l) alist) in
  header :: body

let load_and_convert csv_fname =
  let open Csv in
  let header, data =
    match load csv_fname with
    | h::tl -> h, tl
    | [] -> assert false
  in
  let associated = associate header data in
  let cleaned = remove_empty_total associated in
  (* convert each row to an expense *)
  List.map expense_of_alist cleaned
  (* |> List.fold_left (fun m e -> ItemMap.add (Expense.name e) e m) ItemMap.empty *)
