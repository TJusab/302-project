
exception NotImplemented

type 'a graph = { 
  nodes: 'a  list;
  edges: ('a * 'a) list
}

let initialize_union_find_tests = []

(** 
  Initializes the Union-Find structure with each node as its own representative and an initial rank of 0.
  Used for tracking connected components and ranks.
  
  @param nodes A list of nodes in the graph.
  @return A tuple containing two hash tables:
          - The first table (`representant`) maps each node to its own initial representative.
          - The second table (`rank`) maps each node to an initial rank of 0.
*)
let initialize_union_find (nodes : 'a list) =
  raise NotImplemented

(** 
  Finds the representant of the node and performs path compression simultaneously.
  This function navigates up the chain of representatives to find the root of the set.

  @param representant A hash table mapping each node to its current representative.
  @param node The node for which to find the representative.
  @return The representative node (root) of the set containing the node
*)
let rec find (representant : ('a, 'a) Hashtbl.t) (node : 'a) =
  raise NotImplemented

(** 
  Finds the representatns of the two sets containing x and y and indicate the presence of a cycle if x and y are already in the same set.
  This function performs union by rank, merging the sets containing x and y under the root with higher rank. If x and y are already in the same set, a cycle is detected.
  
  @param representant A hash table mapping each node to its representative in the Union-Find structure.
  @param rank A hash table mapping each node to its rank in the Union-Find structure.
  @param x The first node to union.
  @param y The second node to union.
  @return A boolean value indicating whether a cycle was detected:
          - `true` if x and y were already in the same set (indicating a cycle).
          - `false` if x and y were in different sets and have now been merged (no cycle).
*)
let union (representant : ('a, 'a) Hashtbl.t) (rank : ('a, int) Hashtbl.t) (x : 'a) (y : 'a) : bool =
  let rep_x = find representant x in
  let rep_y = find representant y in
  if rep_x <> rep_y then
    raise NotImplemented (* No cycle detected *)
  else
    raise NotImplemented (* Cycle detected *)

let detect_cyle_tests: ('a graph * bool) list = [
  ({ nodes = []; edges = [] }, false); (* Empty graph *)
  ({ nodes = ['a'; 'b']; edges = [('a', 'b')] }, false);
  ({ nodes = ['a'; 'b'; 'c']; edges = [('a', 'b'); ('b', 'c'); ('c', 'a')] }, true); (* Graph with cycle *)
  ({ nodes = ['a'; 'b'; 'c']; edges = [('a', 'b')] }, false);
  ({ nodes = ['a']; edges = [] }, false); (* Graph with single node *)
]

(** 
  Detects if there is a cycle in the graph using the Union-Find data structure.
  Can be implemented by first initializing a union-find structure, then iteratively calling union on each edge.
  
  @param graph The input graph.
  @return A boolean value indicating whether the graph contains a cycle:
          - `true` if a cycle is detected,
          - `false` otherwise.
*)
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