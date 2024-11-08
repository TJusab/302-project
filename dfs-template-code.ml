
exception NotImplemented

(* White is unvisited
   Grey is currently in DFS stack
   Black is fully explored
*)
type color = White | Grey | Black

type 'a graph = { 
  nodes: ('a * color ref) list;
  edges: ('a * 'a) list
}

(* We want to use DFS to detect cycles in an undirected graph *)
(*
    1. Start DFS from an unvisited (White) node
    2. Mark the node as Grey (being visited).
    3. For each neighbor of the node:
        3. a. If the neighbor is White, apply DFS on it
        3. b. If the neighbor is Grey (and it's not the parent of the current node),
              a cycle exists
    4. Mark the node as Black after exploring all its neighbors
*)

let find_neighbors_tests: (('a graph * 'a) * 'a list) list = []

(* Use List.fold_left *)
let find_neighbors (graph: 'a graph) (vertex: 'a): 'a list =
  raise NotImplemented

let dfs_tests: (('a graph * 'a * 'a option) * bool) list = []

(* May use List.assoc to look up and edit vertex color *)
(* Use List.exists *)
let rec dfs (graph: 'a graph) (vertex: 'a) (parent: 'a option): bool =
  raise NotImplemented

let detect_cyle_tests: ('a graph * bool) list = []

(* Use List.exists *)
let detect_cycle (graph: 'a graph): bool = 
  raise NotImplemented