type 'a graph = { 
  nodes: 'a  list;
  edges: ('a * 'a) list
}

(* Creates the parent and rank tables and sets each node as its own parent with an initial rank of 0 *)
let initialize_union_find (nodes : 'a list) =
  let parent = Hashtbl.create (List.length nodes) in
  let rank = Hashtbl.create (List.length nodes) in
  List.iter (fun node ->
    Hashtbl.add parent node node;  (* Each node is its own parent *)
    Hashtbl.add rank node 0        (* Initial rank is 0 *)
  ) nodes;
  (parent, rank)

(* Finds the parent of the done and performs path compression simultaneously *)
let rec find (parent : ('a, 'a) Hashtbl.t) (node : 'a) =
  let root = Hashtbl.find parent node in
  if root <> node then
    let root_parent = find parent root in
    Hashtbl.replace parent node root_parent;  (* Path compression *)
    root_parent
  else
    root

(* Finds the roots of the two sets containing x and y and indicate the presence of a cycle 
   if x and y are already in the same set  *)
let union (parent : ('a, 'a) Hashtbl.t) (rank : ('a, int) Hashtbl.t) (x : 'a) (y : 'a) : bool =
  let root_x = find parent x in
  let root_y = find parent y in
  if root_x <> root_y then
    let rank_x = Hashtbl.find rank root_x in
    let rank_y = Hashtbl.find rank root_y in
    if rank_x > rank_y then
      Hashtbl.replace parent root_y root_x
    else if rank_x < rank_y then
      Hashtbl.replace parent root_x root_y
    else (
      Hashtbl.replace parent root_y root_x;
      Hashtbl.replace rank root_x (rank_x + 1)
    );
    false (* No cycle detected *)
  else
    true (* Cycle detected *)


(* Detect cycle function *)
let detect_cycle (g : 'a graph) : bool =
  let parent, rank = initialize_union_find g.nodes in
  List.exists (fun (u, v) -> union parent rank u v) g.edges


(* Example usage *)
let () =
  let graph = {
    nodes = [0; 1; 2; 3; 4];
    edges = [(0, 1); (1, 2); (2, 3); (3, 4); (4, 1)]
  } in
  if detect_cycle graph then
    Printf.printf "Cycle detected!\n"
  else
    Printf.printf "No cycle found.\n"