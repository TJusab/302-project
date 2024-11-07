type 'a graph = { 
  nodes: 'a  list;
  edges: ('a * 'a) list
}

(* Creates the representant and rank tables and sets each node as its own representant with an initial rank of 0 *)
let initialize_union_find (nodes : 'a list) =
  let representant = Hashtbl.create (List.length nodes) in
  let rank = Hashtbl.create (List.length nodes) in
  List.iter (fun node ->
    Hashtbl.add representant node node;  (* Each node is its own representant *)
    Hashtbl.add rank node 0        (* Initial rank is 0 *)
  ) nodes;
  (representant, rank)

(* Finds the representant of the node and performs path compression simultaneously *)
let rec find (representant : ('a, 'a) Hashtbl.t) (node : 'a) =
  let rep = Hashtbl.find representant node in
  if rep <> node then
    let rep_representant = find representant rep in
    Hashtbl.replace representant node rep_representant;  (* Path compression *)
    rep_representant
  else
    rep

(* Finds the reps of the two sets containing x and y and indicate the presence of a cycle 
   if x and y are already in the same set  *)
let union (representant : ('a, 'a) Hashtbl.t) (rank : ('a, int) Hashtbl.t) (x : 'a) (y : 'a) : bool =
  let rep_x = find representant x in
  let rep_y = find representant y in
  if rep_x <> rep_y then
    let rank_x = Hashtbl.find rank rep_x in
    let rank_y = Hashtbl.find rank rep_y in
    if rank_x > rank_y then
      Hashtbl.replace representant rep_y rep_x
    else if rank_x < rank_y then
      Hashtbl.replace representant rep_x rep_y
    else (
      Hashtbl.replace representant rep_y rep_x;
      Hashtbl.replace rank rep_x (rank_x + 1)
    );
    false (* No cycle detected *)
  else
    true (* Cycle detected *)


(* Detect cycle function *)
let detect_cycle (g : 'a graph) : bool =
  let representant, rank = initialize_union_find g.nodes in
  List.exists (fun (u, v) -> union representant rank u v) g.edges


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