open ExtLib

let subsets xs = List.fold_right (fun x rest -> rest @ List.map (fun ys -> x::ys) rest) xs [[]]
let pr = List.iter (fun d -> print_int d; output_string stdout " ")

let () =
  let univ = [1; 3; 6; 8; 12] in
  let pw = subsets univ in

  let h = Hashtbl.create 1 in
  List.iteri (fun i l -> Hashtbl.add h l i) pw;

  let n = List.length pw in
  let g = Mygraph.create n in

  List.iteri (fun i l ->
    List.iter (fun k ->
      let l2 = List.remove l k in
      let l2i = Hashtbl.find h l2 in
      Mygraph.add_edge_u g i l2i k
    ) l
  ) pw;

  List.iteri (fun i l ->
    List.iter (fun k ->
      let l2 = List.remove l k in
      let l2i = Hashtbl.find h l2 in
      Mygraph.add_edge_u g i l2i k
    ) l
  ) pw;


  let module Dijkstra = Graph.Path.Dijkstra(Mygraph)(Mygraph.W) in
  let src = Hashtbl.find h univ and dst = Hashtbl.find h [] in
  let (_,length) = Dijkstra.shortest_path g src dst in

  print_int length; print_endline ""
