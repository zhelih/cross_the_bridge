let subsets xs = List.fold_right (fun x rest -> rest @ List.map (fun ys -> x::ys) rest) xs [[]]
let pr = List.iter (fun d -> print_int d; output_string stdout " ")

let () =
  let univ = [1; 3; 6; 8; 12] in
  let pw = subsets univ in

  let left_side = pw in
  let right_side = pw in

  let n = List.length left_side in
  let g = Mygraph.create (2*n) in

  let module Dijkstra = Graph.Path.Dijkstra(Mygraph)(Mygraph.W) in
  let (_,length) = Dijkstra.shortest_path g 0 1 in
  print_int length; print_endline ""
