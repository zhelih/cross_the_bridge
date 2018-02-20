let subsets xs = List.fold_right (fun x rest -> rest @ List.map (fun ys -> x::ys) rest) xs [[]]
let pr = List.iter (fun d -> print_int d; output_string stdout " ")

let () =
  let univ = [1; 3; 6; 8; 12] in
  let pw = subsets univ in

  let _left_side = pw in
  let _right_side = pw in

(*   let module G = Path in *)
  let module G = Graph.Path in
(*   let module G = Ocamlgraph.Path in *)
(*   let module G = OcamlGraph.Path in *)
  let module Dijkstra = Graph.Path.Dijsktra(Mygraph)(Mygraph.W) in
  ()
