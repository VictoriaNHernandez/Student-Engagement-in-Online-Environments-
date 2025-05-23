# Clustering Student Engagement in Online Learning Environments

This project applies k-means clustering to a synthetically generated dataset that simulates student engagement behavior in online learning platforms. The goal is to identify patterns and group students into meaningful clusters (low, moderate, and high engagement) that could inform targeted interventions in educational settings.

## 📂 Dataset

The dataset was created using generative AI (ChatGPT) and includes 999 student records across six attributes:

- `avg_session_time`: Average session duration
- `assignments_completed`: Assignments submitted in the past month
- `video_watch_pct`: Percentage of course videos watched
- `forum_posts`: Participation in discussion forums
- `quizzes_attempted`: Number of quizzes attempted
- `avg_score`: Average quiz score

## 🔧 Methods

### Preprocessing
- Checked for missing values (none found)
- Normalized data to a 0–1 scale using min-max rescaling

### Exploratory Data Analysis
- Summary statistics (mean, SD, quartiles)
- Pair plots and box plots for visual pattern recognition

### Clustering
- **K-means** clustering algorithm
- Elbow Method and Silhouette Scores used to determine optimal number of clusters (k = 3 selected)
- Visualized clusters using:
  - Silhouette plots
  - Pair plots
  - Box plots

## 📊 Results

The analysis revealed three clear clusters:

- **Cluster 1 – High Engagement**: High scores in all categories (session time, quizzes, forum activity)
- **Cluster 2 – Moderate Engagement**: Mid-range scores across all features
- **Cluster 3 – Low Engagement**: Minimal participation and low performance

These results can help educators identify students who may benefit from additional support or intervention.

## 📈 Visualizations

- Elbow plot for optimal `k` selection
- Silhouette plots to assess cluster quality
- Box plots for variable distribution across clusters
- Pair plots to visualize multidimensional relationships

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/VictoriaNHernandez/student-engagement-clustering
   cd student-engagement-clustering
