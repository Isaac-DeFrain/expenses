(* Include card/acct numbers? *)
type t = CREDIT_CARD | BANK_ACCT

let ba = BANK_ACCT

let cc = CREDIT_CARD

let show_t = function
| BANK_ACCT -> "Bank acct"
| CREDIT_CARD -> "Credit card"
