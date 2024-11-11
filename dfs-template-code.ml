
exception NotImplemented

type 'a graph = { 
  nodes: ('a * color ref) list;
  edges: ('a * 'a) list
}

(* White is unvisited
   Grey is currently in DFS stack
   Black is fully explored
*)
type color = White | Grey | Black

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

(**
  Initializes the color map for each node in the graph.
  
  @param graph The input graph.
  @return A list of pairs containing a node and a reference to its color (initially White).
          This list will be used to track the status of each node during DFS traversal.
*)
let initialize_graph (graph: 'a graph): ('a * color ref) list = List.map(fun node -> (node, ref White)) graph.nodes

let find_neighbors_tests: (('a graph * 'a) * 'a list) list = [
  (({ nodes = ['a'; 'b'; 'c']; edges = [('a', 'b'); ('b', 'c')] }, 'a'), ['b']);
  (({ nodes = ['a'; 'b'; 'c']; edges = [('a', 'b'); ('b', 'c')] }, 'b'), ['a'; 'c']);
  (({ nodes = ['a'; 'b'; 'c']; edges = [('a', 'b'); ('b', 'c')] }, 'c'), ['b']);
  (({ nodes = ['a'; 'b'; 'c'; 'd']; edges = [('a', 'b'); ('b', 'c'); ('c', 'd'); ('d', 'a')] }, 'd'), ['a'; 'c']);
  (({ nodes = ['a'; 'b'; 'c']; edges = [] }, 'a'), [])
]

(** 
  Finds all neighbors of a given vertex in an undirected graph.
  
  @param graph The input graph.
  @param vertex The node for which neighbors are to be found.
  @return A list of neighbors directly connected to the given vertex.
*)
let find_neighbors (graph: 'a graph) (vertex: 'a): 'a list =
  raise NotImplemented

let dfs_tests: (('a graph * (('a * color ref) list) * 'a * 'a option) * bool) list = [
  (({ nodes = ['a'; 'b']; edges = [('a', 'b')] }, [('a', ref White); ('b', ref White)], 'a', None), false);
  (({ nodes = ['a'; 'b'; 'c']; edges = [('a', 'b'); ('b', 'c'); ('c', 'a')] }, [('a', ref White); ('b', ref White); ('c', ref White)], 'a', None), true);
  (({ nodes = ['a'; 'b'; 'c']; edges = [('a', 'b')] }, [('a', ref White); ('b', ref White); ('c', ref White)], 'b', None), false);
  (({ nodes = ['a']; edges = [] }, [('a', ref White)], 'a', None), false);
]

(** 
  Performs a depth-first search (DFS) from a given vertex to detect cycles in an undirected graph.

  @param graph The input graph.
  @param color_map A list of pairs containing a node and its mutable color reference to track its status.
  @param vertex The current node being visited in the DFS traversal.
  @param parent Previous node in the DFS path.
  @return A boolean value indicating whether a cycle is detected:
          - `true` if a cycle is found,
          - `false` otherwise.
*)
let rec dfs (graph: 'a graph) (color_map: ('a * color ref) list) (vertex: 'a) (parent: 'a option): bool =
  raise NotImplemented

let detect_cyle_tests: ('a graph * bool) list = [
  ({ nodes = ['a'; 'b']; edges = [('a', 'b')] }, false);
  ({ nodes = ['a'; 'b'; 'c']; edges = [('a', 'b'); ('b', 'c'); ('c', 'a')] }, true);
  ({ nodes = ['a'; 'b'; 'c']; edges = [('a', 'b')] }, false);
  ({ nodes = ['a']; edges = [] }, false);
]

(** 
  Detects if there is a cycle in the graph by applying DFS to each unvisited node.
  Can be implemented by first initializing a color map, then calling DFS on each unvisited node to determine if cycle exists.
  
  @param graph The input graph.
  @return A boolean value indicating whether the graph contains a cycle:
          - `true` if a cycle is detected,
          - `false` otherwise.
*)
let detect_cycle (graph: 'a graph): bool = 
  raise NotImplemented