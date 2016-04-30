
library(rodham)
library(igraph)
library(ggnetwork)
library(svgPanZoom)
library(ggrepel)
library(SVGAnnotation)

data("emails")

edges <- edges_emails(emails)
nodes <- nodes_emails(emails)

g <- graph.data.frame(edges, vertices = nodes)

V(g)$color <- rev(colorRampPalette(RColorBrewer:::brewer.pal(5, "YlOrRd"))(length(V(g)$weight)))

dat <- ggnetwork(g, layout="fruchtermanreingold", arrow.gap=0, cell.jitter=0)

ggplot() +
  geom_edges(data=dat, 
             aes(x=x, y=y, xend=xend, yend=yend),
             color="grey50", curvature=0.1, size=0.15, alpha=1/2) +
  geom_nodes(data=dat,
             aes(x=x, y=y, xend=xend, yend=yend, size=sqrt(weight.x)),
             alpha=1/3) +
  geom_label_repel(data=unique(dat[dat$size>50,c(1,2,5)]),
                   aes(x=x, y=y, label=vertex.names), 
                   size=2, color="#8856a7") +
  theme_blank() +
  theme(legend.position="none") -> gg

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
