module type X__1 = sig type t val eq : (t -> (t -> bool)) end module type X__2 = sig type elt type set val member : (elt -> (set -> bool)) end module type X__3 = sig type elt type set val member : (elt -> (set -> bool)) code end module type X__5 = sig type t val eq : (t -> (t -> bool)) code end module type X__6 = sig type t val eq : (t -> (t -> bool)) code end module type X__7 = sig type elt type set val member : (elt -> (set -> bool)) end module type EQ = X__1 module type S = X__2
let makeSet (type a)  = (fun (m: (module X__5 with type t = a)) -> (module struct module X__4 = (val m) type elt = X__4.t type set = (X__4.t list) let member   = .<let rec member  elt set = match set with
| (hd :: tl) -> (((.~(X__4.eq) elt) hd) || ((member elt) tl))
| _ -> false
 in member>. end : X__3 with type elt = a and type set = (a list)));; let intset_cod   = (makeSet (module struct type t = int let eq   = .<(fun x -> (fun y -> (x = y)))>. end : X__6 with type t = int));; let intset   = (module struct module X__8 = (val intset_cod) type elt = X__8.elt type set = X__8.set let member   = Runcode.run (X__8.member) end : X__7 with type elt = int and type set = (int list));;
