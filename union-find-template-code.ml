
exception NotImplemented

type 'a graph = { 
  nodes: 'a  list;
  edges: ('a * 'a) list
}

let initialize_union_find_tests = []

(* Creates the representant and rank tables and sets each node as its own representant with an initial rank of 0 *)
(* Use Hashtable functions: Hashtbl.create, Hashtbl.add *)
let initialize_union_find (nodes : 'a list) =
  raise NotImplemented

(* Finds the representant of the node and performs path compression simultaneously *)

let find_tests = []

let rec find (representant : ('a, 'a) Hashtbl.t) (node : 'a) =
  raise NotImplemented

(* Finds the reps of the two sets containing x and y and indicate the presence of a cycle 
   if x and y are already in the same set  *)

let union_tests: ((('a, 'a) Hashtbl.t * ('a, int) Hashtbl.t * 'a * 'a) * bool) list = []

let union (representant : ('a, 'a) Hashtbl.t) (rank : ('a, int) Hashtbl.t) (x : 'a) (y : 'a) : bool =
  let rep_x = find representant x in
  let rep_y = find representant y in
  if rep_x <> rep_y then
    raise NotImplemented (* No cycle detected *)
  else
    raise NotImplemented (* Cycle detected *)

let detect_cyle_tests: ('a graph * bool) list = []

(* Detect cycle function *)
let detect_cycle (g : 'a graph) : bool =
  raise NotImplemented

  
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