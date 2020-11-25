type date = Date.t

type price = Price.t

type pmt_meth = Payment_method.t

type t = { date: date option; amount: price option; vendor: string; what: string; payment_method: pmt_meth option }

let mk_expense ~date ~amount ~vendor ~what ~payment_method =
  { date; amount; vendor; what; payment_method }

let rec to_string { date; amount; vendor; what; payment_method } =
  "What: " ^ what ^ "\n" ^
  "Date: " ^ show_date_opt date ^ "\n" ^
  "Amount: " ^ show_price_opt amount ^ "\n" ^
  "Vendor: " ^ vendor ^ "\n" ^
  "Payment method: " ^ show_pmt_opt payment_method

and show_date_opt =
  Core.Option.value_map ~default:"N/A" ~f:Date.to_string

and show_price_opt =
  Core.Option.value_map ~default:"N/A" ~f:Price.to_string

and show_pmt_opt =
  Core.Option.value_map ~default:"Need to add payment info" ~f:Payment_method.to_string

let name exp = exp.what

let print_t exp = print_endline (to_string exp)

let total exps =
  List.map (fun exp -> exp.amount |> Core.Option.value_map ~default:Price.zero ~f:Fun.id) exps
  |> Price.total
