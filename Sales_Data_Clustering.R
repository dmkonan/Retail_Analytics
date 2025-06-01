# Customer Segmentation using Clustering Algorithm

# Load necessary libraries
library(dplyr)
library(cluster)
library(factoextra)

# Load the Sales dataset previously cleaned in Python
setwd("~/Python files/")
sales_data <- read.csv("Cleaned_Sales_data.csv")

# Data Preprocessing
# Aggregate data by Customer Name to compute purchase frequency, average order value, and region (assuming 'State' as region)
customer_data <- sales_data %>%
  group_by(Customer.Name, State) %>%
  summarise(
    Purchase_Frequency = n(),
    Avg_Order_Value = mean(Total)
  )

# Normalize the data for clustering
customer_data_scaled <- scale(customer_data[, c("Purchase_Frequency", "Avg_Order_Value")])

# Perform K-means clustering (assuming 3 clusters as a start)
set.seed(123)
kmeans_result <- kmeans(customer_data_scaled, centers = 3)

# Add cluster information to the dataset
customer_data$Cluster <- as.factor(kmeans_result$cluster)

# Visualize the clusters
fviz_cluster(list(data = customer_data_scaled, cluster = kmeans_result$cluster))

# View clustered data
head(customer_data)
