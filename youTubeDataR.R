library(youTubeDataR)

TK <- youOAuth("170154703320-fidke6385rgnh9eiksqln0c5m6iln7me.apps.googleusercontent.com",
               "UozGE2FxXnAhxn2zme5uvLIT")

search <- searchTube(TK, "programming", type = "video")

vids <- data.frame()
for(i in 1:nrow(search)){
  vid <- getVideos(TK, id = search$id.videoId[i], chart = NULL, 
                   part = "statistics")
  vids <- plyr::rbind.fill(vids, vid)
  Sys.sleep(1)
}

vids$statistics.viewCount <- as.numeric(paste(vids$statistics.viewCount))

library(ggplot2)
library(plotly)

h <- reshape2::melt(vids, "id", 
                    c("statistics.likeCount", "statistics.dislikeCount"))

vids$statistics.commentCount <- as.numeric(paste(vids$statistics.commentCount))
vids$statistics.dislikeCount <- as.numeric(paste(vids$statistics.dislikeCount))
vids$statistics.likeCount <- as.numeric(paste(vids$statistics.likeCount))

x <- vids$statistics.viewCount

vids$size <- (x-min(x))/(max(x)-min(x))

vids$size <- log1p(vids$size) * 100

names(vids)[4] <- "views"

plot_ly(vids, x = statistics.dislikeCount, y = statistics.likeCount,
        mode = "markers", color = views,
        opacity = views,
        marker = list(
          size = size
        )) %>%
  layout(xaxis = list(
    showgrid = FALSE,
    title = "dislikes"
  ),
  yaxis = list(
    showgrid = FALSE,
    title = "likes"
  ),
  title = "programming on youTube")
  

