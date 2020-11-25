type t = { sign: sign; dollars: int; cents: int }

and sign = Pos | Neg

let pos_or_neg i = if i >= 0 then Pos else Neg

let same_sign a b =
  let a_sign = pos_or_neg a in
  let b_sign = pos_or_neg b in
  let both_pos = a_sign = Pos && b_sign = Pos in
  let both_neg = a_sign = Neg && b_sign = Neg in
  both_pos || both_neg

let mk_price ~d ~c =
  let c' = (abs c) mod 100 in
  if same_sign d c then
  let d' = (abs d) + (abs c) / 100 in
  { sign = pos_or_neg (d * 100 + c); dollars = d'; cents = c'}
  else
  let d' = (abs d) - (abs c) / 100 |> abs in
  { sign = pos_or_neg (d * 100 + c); dollars = d'; cents = c'}

let dollars p = p.dollars

let cents p = p.cents

let show_sign = function
| Pos -> "+"
| Neg -> "-"

let of_string s =
  match String.split_on_char '.' s with
  | d'::c'::_ -> mk_price ~d:(int_of_string d') ~c:(int_of_string c')
  | _ -> assert false

let to_string {sign; dollars; cents} =
  if cents < 10 then show_sign sign ^ "$" ^ string_of_int dollars ^ ".0" ^ string_of_int cents
  else show_sign sign ^ "$" ^ string_of_int dollars ^ "." ^ string_of_int cents

let ( + ) p1 p2 = mk_price ~d:(p1.dollars + p2.dollars) ~c:(p1.cents + p2.cents)

let ( - ) p1 p2 = mk_price ~d:(p1.dollars - p2.dollars) ~c:(p1.cents - p2.cents)

let zero = mk_price ~d:0 ~c:0

let total = List.fold_left (+) zero

include Core.Poly
