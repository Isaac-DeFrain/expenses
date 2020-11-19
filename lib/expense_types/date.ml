type t = Core.Date.t

let of_string = Core.Date.of_string

let to_string = Core.Date.to_string

(* MST = UTC-7; MDT = UTC-6 *)
let today_opt_utc_offset =
  let open Core in
  Option.value_map
    ~default:(Date.today ~zone:Time.Zone.utc)
    ~f:(fun offset -> Date.today ~zone:(Time.Zone.of_utc_offset ~hours:offset))
