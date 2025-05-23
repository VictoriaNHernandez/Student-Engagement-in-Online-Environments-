library(cluster)
library(fpc)
library(scales)
library(ggplot2)
library(dplyr)
library(caret)
library(tidyr)

#Read customer online csv file
online <- read.csv(file="online_learning.csv", stringsAsFactors = TRUE)
summary(online)

#Check for Na values
online <- online[complete.cases(online),]
summary(online)

#Boxplot
cleaned_numeric <- online[, sapply(online, is.numeric)]
boxplot(cleaned_numeric, 
        main = "Boxplot of Student Engagement Variables", 
        col = "lightgreen", 
        las = 1,           
        cex.axis = 0.8) 

#Scale from 0 to 1
online_norm <- online
online_norm$avg_session_time <- rescale(online$avg_session_time, to = c(0,1))
online_norm$assignments_completed <- rescale(online$assignments_completed, to = c(0,1))
online_norm$video_watch_pct <- rescale(online$video_watch_pct, to = c(0,1))
online_norm$forum_posts <- rescale(online$forum_posts, to = c(0,1))
online_norm$quizzes_attempted <- rescale(online$quizzes_attempted, to = c(0,1))
online_norm$avg_score <- rescale(online$avg_score, to = c(0,1))

summary(online_norm)

#run k-means with k = 2
km2 <- kmeans(online_norm, centers = 2) 
km2

#visualize results colored by cluster
pairs(online, col=km2$cluster)

#run k-means with k = 3
km3 <- kmeans(online_norm, centers = 3) 
km3

summary(as.factor(km3$cluster))

#visualize results colored by cluster
pairs(online, col=km3$cluster)

library(reshape2)
#Add cluster original data
online$cluster <- as.factor(km2$cluster)

#Select numeric columns
numeric_vars <- names(online)[sapply(online, is.numeric) & names(online) != "cluster"]

#Melt data for ggplot
online_melt <- melt(online, id.vars = "cluster", measure.vars = numeric_vars)

#Plot all boxplots
ggplot(online_melt, aes(x = cluster, y = value, fill = cluster)) +
  geom_boxplot() +
  facet_wrap(~ variable, scales = "free_y") +
  labs(title = "Distribution of Variables by Cluster", y = "Value") +
  theme_minimal()

library(reshape2)
#km3
online$cluster <- as.factor(km3$cluster)  

numeric_vars <- names(online)[sapply(online, is.numeric) & names(online) != "cluster"]

online_melt <- melt(online, id.vars = "cluster", measure.vars = numeric_vars)

#Plot all boxplots
ggplot(online_melt, aes(x = cluster, y = value, fill = cluster)) +
  geom_boxplot() +
  facet_wrap(~ variable, scales = "free_y") +
  labs(title = "Distribution of Variables by Cluster", y = "Value") +
  theme_minimal()


#create distance matrix
distm <- dist(online_norm)  

#evaluate k-means results
#Cluster statistics for km2
cstatskm2 = cluster.stats(distm,km2$cluster)
#Cluster statistics for km3
cstatskm3 = cluster.stats(distm,km3$cluster) 
#evaluate between and within cluster distances
cstatskm2$average.between
cstatskm2$average.within
cstatskm3$average.between
cstatskm3$average.within

#Silhouette plots
sil2 <- silhouette(km2$cluster,distm)
avg_sil2 <- mean(sil2[,3])
avg_sil2
plot(sil2)
#save plots
png("silhouette_k2.png", width = 1200, height = 800)
plot(silhouette(km2$cluster, distm))
dev.off()

sil3 <- silhouette(km3$cluster,distm)
avg_sil3 <- mean(sil3[,3])
avg_sil3
plot(sil3)
#save plots
png("silhouette_k3.png", width = 1200, height = 800)
plot(silhouette(km3$cluster, distm))
dev.off()

#Find number of clusters with elbow method k-means silhouette coefficient
avg_sil <- 0
count <- 1 
#Elbow method using k-means and silhouette coefficient
for (k in 2:10){
  km <- kmeans(online_norm, centers=k)
  sil <- silhouette(km$cluster,distm)
  #print(mean(sil[,3]))
  avg_sil[count] <- mean(sil[, 3])
  count <- count+1
}
plot(c(2:10),avg_sil)
lines(c(2:10),avg_sil)


