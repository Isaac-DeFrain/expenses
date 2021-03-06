type t

val mk_price : d:int -> c:int -> t
val dollars : t -> int
val cents : t -> int
val of_string : string -> t
val to_string : t -> string
val zero : t
val total : t list -> t

val ( + ) : t -> t -> t
val ( - ) : t -> t -> t
val compare : t -> t -> int
val ascending : t -> t -> int
val descending : t -> t -> int
val ( < ) : t -> t -> bool
val ( <= ) : t -> t -> bool
val ( <> ) : t -> t -> bool
val ( = ) : t -> t -> bool
val ( > ) : t -> t -> bool
val ( >= ) : t -> t -> bool
val equal : t -> t -> bool
val min : t -> t -> t
val max : t -> t -> t
