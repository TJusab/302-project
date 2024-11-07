
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

let find_neighbors (graph: 'a graph) (vertex: 'a): 'a list =
  raise NotImplemented

let rec dfs (graph: 'a graph) (vertex: 'a) (parent: 'a option): bool =
  let vertex_color = (List.assoc vertex graph.nodes) in
  vertex_color := Grey;
  
  let neighbors = find_neighbors graph vertex in
  List.exists (fun neighbor ->
      let neighbor_color = List.assoc neighbor graph.nodes in
      match !neighbor_color with
      | White ->
          if dfs graph neighbor (Some vertex) then true else false 
      | Grey ->
          (* If the neighbor is Grey and not the parent, cycle found *)
          (match parent with
           | Some p when p = neighbor -> false (* If the neighbor is the parent, ignore *)
           | _ -> true)
      | Black -> false
    ) neighbors
  
let detect_cycle (graph: 'a graph): bool = 
  List.exists (fun (vertex, color) ->
      if !color = White then dfs graph vertex None
      else false
    ) graph.nodes