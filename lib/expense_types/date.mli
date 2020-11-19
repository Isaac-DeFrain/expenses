type t

val of_string : string -> t
val to_string : t -> string
val today_opt_utc_offset : int option -> t
