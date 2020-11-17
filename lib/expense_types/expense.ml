open Core.Time
open Payment_method
open Price

type time = t

type expense = { date: time option; amount: price option; vendor: string; what: string; payment_method: pmt }
