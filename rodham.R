
library(rodham)
library(igraph)

data("emails")

edges <- edges_emails(emails)
nodes <- nodes_emails(emails)

g <- graph.data.frame(edges, vertices = nodes)

V(g)$color <- rev(colorRampPalette(RColorBrewer:::brewer.pal(5, "YlOrRd"))(length(V(g)$weight)))

plot(g, layout = layout.fruchterman.reingold(g), vertex.color = V(g)$color,
     vertex.label.family = "sans",
     vertex.label.color = hsv(h = 0, s = 0, v = 0, alpha = 0.0), 
     vertex.size = log1p(degree(g)) * 3, edge.arrow.size = 0.2, 
     edge.arrow.width = 0.3, edge.width = 1,
     edge.color = hsv(h = 1, s = .59, v = .91, alpha = 0.7),
     vertex.frame.color="#FFFFFF")

library(networkD3)

edges <- edges[edges$from == "Hillary Clinton" || edges$to == "Hillary Clinton", ]

simpleNetwork(edges)
