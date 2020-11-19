type date = Date.t

type price = Price.t

type pmt_meth = Payment_method.t

type t = { date: date option; amount: price option; vendor: string; what: string; payment_method: pmt_meth }

let mk_expense ~date ~amount ~vendor ~what ~payment_method =
  { date; amount; vendor; what; payment_method }

let rec to_string { date; amount; vendor; what; payment_method } =
  "What: " ^ what ^ "\n" ^
  "Date: " ^ show_date_opt date ^ "\n" ^
  "Amount: " ^ show_price_opt amount ^ "\n" ^
  "Vendor: " ^ vendor ^ "\n" ^
  "Payment method: " ^ Payment_method.to_string payment_method

and show_date_opt = function
| None -> "N/A"
| Some d -> Date.to_string d

and show_price_opt = function
| None -> "N/A"
| Some p -> Price.to_string p

let print_t exp = print_endline (to_string exp)
