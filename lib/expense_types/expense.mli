type t
type date = Date.t
type price = Price.t
type pmt_meth = Payment_method.t

val mk_expense : date:date option -> amount:price option -> vendor:string -> what:string -> payment_method:pmt_meth -> t
val to_string : t -> string
val print_t : t -> unit
