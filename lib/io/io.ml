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

let expense_of_alist = function
| [d; a; v; w; p] ->
    Expense.mk_expense ~date:(date_opt_of_assoc d) ~amount:(price_opt_of_assoc a)
      ~vendor:(vendor_of_assoc v) ~what:(what_of_assoc w)
      ~payment_method:(pmt_opt_of_assoc p)
| _ -> assert false

let remove_empty_total =
  List.filter (
    let open Core.Poly in
    fun l -> l <>  ["Date", ""; "Amount", ""; "Who", ""; "What", ""; "Payment method", ""]
      && List.hd l <> ("Date", "Total"))

let load_and_convert fname =
  let open Csv in
  let header, data =
    match load fname with
    | h::tl -> h, tl
    | [] -> assert false
  in
  let associated = associate header data in
  let cleaned = remove_empty_total associated in
  List.map expense_of_alist cleaned
  (* |> List.fold_left (fun m e -> ItemMap.add (Expense.name e) e m) ItemMap.empty *)

(* remove empty rows *)
(* convert rows to expense *)
