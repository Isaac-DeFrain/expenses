(* Include card/acct numbers? *)
type t = CREDIT_CARD | BANK_ACCT

let ba = BANK_ACCT

let cc = CREDIT_CARD

let to_string = function
| BANK_ACCT -> "Bank acct"
| CREDIT_CARD -> "Credit card"
