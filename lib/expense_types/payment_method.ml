type t =
  | CREDIT_CARD of string
  | BANK_ACCT of string

let ba = BANK_ACCT ""

let cc = CREDIT_CARD ""

let of_string s =
  let open String in
  match split_on_char ':' s with
  | t'::rest ->
      if Core.List.is_empty rest then
      if t' = "Bank acct" then ba
      else cc
      else
      let s' = trim (concat "" rest) in
      if t' = "Bank acct" then BANK_ACCT s'
      else CREDIT_CARD s'
  | _ -> assert false

let to_string = function
| BANK_ACCT "" -> "Bank acct"
| BANK_ACCT s -> "Bank acct: " ^ s
| CREDIT_CARD "" -> "Credit card"
| CREDIT_CARD s -> "Credit card: " ^ s
