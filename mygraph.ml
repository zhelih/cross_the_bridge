(* my module for Graphs *)
open ExtLib

module V = struct
type t = int
let compare = compare
let hash = Hashtbl.hash
let equals = (=)
end

module E = struct
type t = int * int * int
type label = int (* weight *)

let src (x,_,_) = x
let dst (_,x,_) = x
let label (_,_,x) = x

let create src label dst = (src,dst, label)
end

module W = struct
type edge = E.t
type t = int
let weight e = E.label e
let compare = compare
let add = (+)
let zero = 0
end

type t = (int * int) DynArray.t array

let create n = Array.init n (fun _ -> DynArray.create ())
let nb_vertex t = Array.length t

let add_edge t src dst w = DynArray.add t.(src) (dst,w)
let iter_vertex f t = for i = 0 to nb_vertex t do f i done
let fold_vertex f t s0 =
  let n = nb_vertex t in
  let rec loop i res = if i = n then res else loop (i+1) (f i res) in
  loop 0 s0

let iter_succ f t v = DynArray.iter (fun (v,_) -> f v) t.(v)
let iter_succ_e f t v = DynArray.iter (fun (v',w) -> f (v,v',w)) t.(v)

let fold_edges_e f t s0 =
  let res = ref s0 in
  for i = 0 to (nb_vertex t) - 1 do
    iter_succ_e (fun e -> res := f e !res) t i
  done;
  !res
