######################################################################
################Plot 1###############################################
library(dplyr)
library(tidyverse)
player_att <- read.csv("~/VDS/VDS2425 Football/Player_Attributes.csv")
player <- read.csv("~/VDS/VDS2425 Football/Player.csv")

# Merging the datasets
df <- merge(player_att, player[, c("player_api_id", "player_name", "birthday")], by = "player_api_id")

# player age at time of rating
df$date <- as.Date(df$date)
df$birthday <- as.Date(df$birthday)
df$age <- as.numeric(difftime(df$date, df$birthday, units = "days")) / 365

# players under 23
young_players <- df %>% filter(age < 23)

# changing in rating over time
trend_df <- young_players %>%
  group_by(player_api_id) %>%
  filter(!is.na(overall_rating)) %>%
  arrange(date) %>%
  summarise(
    player_name = first(player_name),
    age_latest = max(age),
    rating_start = first(overall_rating),
    rating_end = last(overall_rating),
    rating_trend = rating_end - rating_start,
    recent_rating = last(overall_rating),
    n_ratings = n()
  ) %>%
  filter(n_ratings >= 3) %>% 
  arrange(desc(rating_trend))

top_young <- trend_df %>% top_n(50, wt = rating_trend)

# Rating trend vs Current rating
ggplot(top_young, aes(x = rating_trend, y = recent_rating, label = player_name)) +
  geom_point(color = "blue", size = 3) +
  geom_text(size = 3, hjust = -0.1, vjust = 0.5) +
  labs(
    title = "Up and Coming Players (Age < 23)",
    x = "Improvement in the Overall Rating",
    y = "Most Recent Rating"
  ) +
  theme_minimal()



#############################################################################
########################Plot 2###############################################
# dataframe
bubble_df <- young_players %>%
  filter(!is.na(overall_rating)) %>%
  arrange(player_api_id, date) %>%
  group_by(player_api_id) %>%
  summarise(
    player_name = first(player_name),
    age_latest = max(age),
    rating_start = first(overall_rating),
    rating_end = last(overall_rating),
    potential = last(potential),
    recent_rating = last(overall_rating),
    rating_trend = rating_end - rating_start,
    n = n()
  ) %>%
  filter(n >= 3, recent_rating > 65) %>%
  mutate(headroom = potential - recent_rating)

# Ploting the bubble chart
ggplot(bubble_df, aes(x = age_latest, y = recent_rating,
                      size = rating_trend, color = headroom)) +
  geom_point(alpha = 0.7) +
  scale_color_gradient(low = "blue", high = "red") +
  scale_size(range = c(2, 10)) +
  labs(
    title = "Age vs Rating with Growth Potential",
    x = "Age",
    y = "Current Rating",
    size = "Improvement",
    color = "Potential Gap"
  ) +
  theme_minimal()

####################################################################
#######################Plot 3#####################################
# Filtering the young players with ratings
young_players <- df %>%
  filter(age < 23, !is.na(overall_rating))

# Get the top improvers
top_improv <- young_players %>%
  arrange(player_api_id, date) %>%
  group_by(player_api_id) %>%
  summarise(
    player_name = first(player_name),
    rating_start = first(overall_rating),
    rating_end = last(overall_rating),
    growth = rating_end - rating_start,
    count = n()
  ) %>%
  filter(count >= 4, growth > 5) %>%
  slice_max(growth, n = 10)

# Filtering the original data of the top players
selected_players <- young_players %>%
  filter(player_api_id %in% top_improv$player_api_id)

# The slope chart
ggplot(selected_players, aes(x = date, y = overall_rating, group = player_name, color = player_name)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(
    title = "Rating of Top Young Improving Players",
    x = "Seasons",
    y = "The Overall Rating",
    color = "Player"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")
