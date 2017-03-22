#####
# Playing around with the DiagrammeR package
#
#

# Clear R's Brain
rm(list = ls())

# creating a node data frame (NDF)
# it's just an R data.frame object

###
# Create an empty graph
###

library(DiagrammeR)

# Create the graph object
graph <- create_graph()

# Get the class of the object
class(graph)
#> [1] "dgr_graph"

# It's an empty graph, so no NDF
# or EDF
get_node_df(graph)
#> NULL

get_edge_df(graph)
#> NULL

# By default, the graph is
# considered as directed
is_graph_directed(graph)
#> [1] TRUE

###
# Create a graph with nodes but no edges
###

node1 <- create_node_df(
  n = 5,
  type = "a",
  label = c("ENDUSE_DISPOSAL", "TREATMENT", "CONVEYANCE", "CONTAINMENT", "USER_INTERFACE"),
  style = "filled",
  color = "aqua",
  shape = "rectangle"
)

node2 <- create_node_df(
  n = 6,
  type = "a",
  label = c("U1_DryToilet", "U2_UDDT", "U3_Urinal", "U4_PourFlushToilet", "U5_CisternFlushToilet", "U6_UDFT"),
  style = "filled",
  color = "aqua",
  shape = "rectangle"
)

graph <- create_graph(nodes_df = node1)

render_graph(graph)


#####
# Create a simple graph
# and display it
###

library(DiagrammeR)

# Create a simple NDF
nodes <-
  create_node_df(
    n = 4,
    nodes = 1:4,
    type = "number")

# Create a simple EDF
edges <-
  create_edge_df(
    from = c(1, 1, 3, 1),
    to = c(2, 3, 4, 4),
    rel = "related")

# Create the graph object,
# incorporating the NDF and
# the EDF, and, providing
# some global attributes
graph <-
  create_graph(
    nodes_df = nodes,
    edges_df = edges,
    graph_attrs = "layout = neato",
    node_attrs = "fontname = Helvetica",
    edge_attrs = "color = gray20")

# View the graph
render_graph(graph)

?create_graph

ndf <-
  create_node_df(
    n = 4,
    label = TRUE,
    type = c("type_4", "type_1",
             "type_5", "type_2"),
    shape = c("circle", "circle",
              "rectangle", "rectangle"),
    values = c(1000, 2.6, 9.4, 2.7))


edf <-
  create_edge_df(
    from = c(1, 2, 3),
    to = c(4, 3, 1),
    rel = "leading_to",
    values = c(7.3, 2.6, 8.3))

graph <-
  create_graph(
    nodes_df = ndf,
    edges_df = edf)

render_graph(graph)


##### 
# Unused diagrams from the SanGL work

### Graph 1

comp <- gs_title("compendium-metadata")
comp <- gs_read(ss = comp, ws = "Sheet4")

comp_d <- comp %>%
  select(id, category, technology, fillcolor, fixedsize, shape, fontcolor, label) %>%
  filter(
    id %in% c(4, 8, 9, 12, 15, 63, 51, 52, 64, 23, 24, 25, 20, 61, 62)
  ) %>%
  mutate(
    id = c(1:15)
  ) 

edf_d <- gs_title("edf_system_a")
edf_d <- gs_read(ss = edf_d, ws = "Sheet4")


graphD <-
  create_graph(
    nodes_df = comp_d,
    edges_df = edf_d)

render_graph(graphD, output = "visNetwork")


comp <- gs_title("compendium-metadata")
comp <- gs_read(ss = comp, ws = "Sheet4")

comp_b <- comp %>%
  select(id, category, technology, fillcolor, fixedsize, shape, fontcolor, label) %>%
  filter(
    id %in% c(1, 2, 7, 8, 9, 51, 19, 20, 25, 45, 46, 61, 62)
  ) %>%
  mutate(
    id = c(1:13)
  ) 

edf_b <- gs_title("edf_system_a")
edf_b <- gs_read(ss = edf_b, ws = "Sheet2")


graphB <-
  create_graph(
    nodes_df = comp_b,
    edges_df = edf_b)

render_graph(graphB)


comp <- gs_title("compendium-metadata")
comp <- gs_read(ss = comp, ws = "Sheet4")

comp_a <- comp %>%
  select(id, category, technology, fillcolor, fixedsize, shape, fontcolor, label) %>%
  filter(
    id %in% c(1, 2, 7, 8, 9, 51, 19, 45, 46)
  ) %>%
  mutate(
    id = c(1:9)
  ) 
edf_a <- gs_title("edf_system_a")
edf_a <- gs_read(ss = edf_a, ws = "Sheet1")

graphA <-
  create_graph(
    nodes_df = comp_a,
    edges_df = edf_a)

render_graph(graphA)

