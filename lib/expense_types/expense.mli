type t
type date = Date.t
type price = Price.t
type pmt_meth = Payment_method.t

val mk_expense : date:date option -> amount:price option -> vendor:string -> what:string -> payment_method:pmt_meth option -> t
val name : t -> string
val to_string : t -> string
val total : t list -> price
val print_t : t -> unit
