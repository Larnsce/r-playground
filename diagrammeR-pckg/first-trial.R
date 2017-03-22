###
# Code from Line 6 is copied from the helpfile ?rend_graph


library(DiagrammeR)

# Create a node data frame (ndf)
ndf1 <-
  create_node_df(   
    n = 10,
    label = c("ENDUSE_DISPOSAL", "TREATMENT", "CONVEYANCE", "CONTAINMENT", "USER_INTERFACE","ENDUSE_DISPOSAL", "TREATMENT", "CONVEYANCE", "CONTAINMENT", "USER_INTERFACE"),
    fixedsize = FALSE,
    shape = c("box", "box", "box", "box", "box"))


dplyr::tbl_df(ndf1) 


# Create an edge data frame (edf)
edf <-
  create_edge_df(
    from = c(1, 2, 3, 4, 6, 7, 8, 9),
    to = c(2, 3, 4, 5, 7, 8, 9, 10),    
    color = "black",
    arrowhead = "normal")

# Create a graph object using the ndf and edf
graph <-
  create_graph(
    nodes_df = ndf1,
    edges_df = edf, 
    attr_theme = NULL)

graph
# Render the graph using Graphviz
render_graph(graph)

render

# Render the graph using VivaGraph
render_graph(graph, output = "vivagraph")

# Render the graph using visNetwork
render_graph(graph, output = "visNetwork")

## End(Not run)
