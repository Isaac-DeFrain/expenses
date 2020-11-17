module Date = Core_kernel.Date
type date = Date.t

module Price = Price
type price = Price.t

module Payment_method = Payment_method
type pmt_meth = Payment_method.t

type t = { date: date option; amount: price option; vendor: string; what: string; payment_method: pmt_meth }

let mk_expense ~date ~amount ~vendor ~what ~payment_method =
  { date; amount; vendor; what; payment_method }

let rec show_t { date; amount; vendor; what; payment_method } =
  "What: " ^ what ^ "\n" ^
  "Date: " ^ show_date_opt date ^ "\n" ^
  "Amount: " ^ show_price_opt amount ^ "\n" ^
  "Vendor: " ^ vendor ^ "\n" ^
  "Payment method: " ^ Payment_method.show_t payment_method

and show_date_opt = function
| None -> "N/A"
| Some d -> Date.to_string d

and show_price_opt = function
| None -> "N/A"
| Some p -> Price.show_t p

let print_t exp = print_endline (show_t exp)
