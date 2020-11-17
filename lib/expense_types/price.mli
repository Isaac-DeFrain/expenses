type price

type sign

val mkPrice : d:int -> c:int -> price

val dollars : price -> int

val cents : price -> int

val show_price : price -> string

val ( + ) : price -> price -> price

val ( - ) : price -> price -> price

val ascending : price -> price -> int

val descending : price -> price -> int

val ( < ) : price -> price -> bool

val ( <= ) : price -> price -> bool

val ( <> ) : price -> price -> bool

val ( = ) : price -> price -> bool

val ( > ) : price -> price -> bool

val ( >= ) : price -> price -> bool

val equal : price -> price -> bool

val min : price -> price -> price

val max : price -> price -> price
