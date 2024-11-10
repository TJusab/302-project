type 'a graph = { 
  nodes: 'a list;
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

let initialize_graph (graph: 'a graph): ('a * color ref) list =
  List.map(fun node -> (node, ref White)) graph.nodes

let find_neighbors (graph: 'a graph) (vertex: 'a): 'a list =
  List.fold_left (fun acc (u, v) ->
      if u = vertex then v :: acc
      else if v = vertex then u :: acc
      else acc
    ) [] graph.edges

let rec dfs (graph: 'a graph) (color_map: ('a * color ref) list) (vertex: 'a) (parent: 'a option): bool =
  let vertex_color = List.assoc vertex color_map in
  vertex_color := Grey;
  
  let neighbors = find_neighbors graph vertex in
  List.exists (fun neighbor ->
      let neighbor_color = List.assoc neighbor color_map in
      match !neighbor_color with
      | White ->
          if dfs graph color_map neighbor (Some vertex) then true else false 
      | Grey ->
          (* If the neighbor is Grey and not the parent, cycle found *)
          (match parent with
           | Some p when p = neighbor -> false (* If the neighbor is the parent, ignore *)
           | _ -> true)
      | Black -> false
    ) neighbors
  
let detect_cycle (graph: 'a graph): bool = 
  let color_map = initialize_graph graph in
  List.exists (fun (vertex, color) ->
      if !color = White then dfs graph color_map vertex None
      else false
    ) color_map