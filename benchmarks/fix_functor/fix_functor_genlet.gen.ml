module type X__1 = sig type int_t type obs_t type unit_t val int : (int -> int_t) val add : (int_t -> (int_t -> int_t)) val sub : (int_t -> (int_t -> int_t)) val mul : (int_t -> (int_t -> int_t)) val div : (int_t -> (int_t -> int_t)) val observe : ((unit_t -> int_t) -> obs_t) end module type X__2 = sig type int_t type obs_t type unit_t val int : (int -> int_t) code val add : (int_t -> (int_t -> int_t)) code val sub : (int_t -> (int_t -> int_t)) code val mul : (int_t -> (int_t -> int_t)) code val div : (int_t -> (int_t -> int_t)) code val observe : ((unit_t -> int_t) -> obs_t) code end module type X__3 = sig type int_t type obs_t type unit_t val int : (int -> int_t) code val add : (int_t -> (int_t -> int_t)) code val sub : (int_t -> (int_t -> int_t)) code val mul : (int_t -> (int_t -> int_t)) code val div : (int_t -> (int_t -> int_t)) code val observe : ((unit_t -> int_t) -> obs_t) code end module type X__5 = sig type int_t type obs_t type unit_t val int : (int -> int_t) code val add : (int_t -> (int_t -> int_t)) code val sub : (int_t -> (int_t -> int_t)) code val mul : (int_t -> (int_t -> int_t)) code val div : (int_t -> (int_t -> int_t)) code val observe : ((unit_t -> int_t) -> obs_t) code end module type S = X__1
let arith   = (module struct 
  type int_t = int type obs_t = int type unit_t = int 
  let int   = genlet .<(fun n1 -> n1)>. 
  let add   = genlet .<(fun n1 -> (fun n2 -> (n1 + n2)))>. 
  let sub   = genlet .<(fun n1 -> (fun n2 -> (n1 - n2)))>. 
  let mul   = genlet .<(fun n1 -> (fun n2 -> (n1 * n2)))>. 
  let div   = genlet .<(fun n1 -> (fun n2 -> (n1 / n2)))>. 
  let observe   = genlet .<(fun f -> (f 0))>. 
end : X__2 with type obs_t = int);; 

let suppressAddZeroOrMulZeroPE   = (fun (m: (module X__5 with type obs_t = int)) -> 
  (module struct 
    module X__4 = (val m) type int_t = (X__4.int_t * bool) type obs_t = int type unit_t = int 
    let int   = genlet .<(fun n1 -> (if (n1 = 0) then ((.~(X__4.int) 0), true) else ((.~(X__4.int) 0), true)))>. 
    let add   = genlet .<(fun n1 -> (fun n2 -> match (n1, n2) with ((n1, b1), (n2, b2)) -> (if (b1 && b2) then ((.~(X__4.int) 0), true) else ((.~(X__4.int) 0), true))))>. 
    let sub   = genlet .<(fun n1 -> (fun n2 -> (if (n1 = n2) then ((.~(X__4.int) 0), true) else ((.~(X__4.int) 0), true))))>. 
    let mul   = genlet .<(fun n1 -> (fun n2 -> match (n1, n2) with | ((n1, b1), (n2, b2)) -> (if (b1 || b2) then ((.~(X__4.int) 0), true) else ((.~(X__4.int) 0), true))))>. 
    let div   = genlet .<(fun n1 -> (fun n2 -> match (n1, n2) with | ((n1, _), (n2, _)) -> (((.~(X__4.div) n1) n2), false)))>. 
    let observe   = genlet .<(fun f -> match (f 0) with | (n, _) -> (.~(X__4.observe) (fun _ -> n)))>. 
  end : X__3 with type obs_t = int));; 
  
let rec fix  depth m = (if (depth <= 0) then m else ((fix (depth - 1)) (suppressAddZeroOrMulZeroPE m)));;
