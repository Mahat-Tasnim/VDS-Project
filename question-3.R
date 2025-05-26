match <- read.csv("~/VDS/VDS2425 Football/Match.csv")
possession <- read.csv("~/VDS/VDS2425 Football/Match_Possesion.csv")
goals <- read.csv("~/VDS/VDS2425 Football/Match_Goals.csv")



library(dplyr)

avg_possession <- possession %>%
  group_by(match_id) %>%
  summarise(homepos = mean(homepos, na.rm = TRUE),
            awaypos = mean(awaypos, na.rm = TRUE))


merged <- match %>%
  left_join(avg_possession, by = c("id" = "match_id")) %>%
  mutate(result = case_when(
    home_team_goal > away_team_goal ~ "Home Win",
    home_team_goal < away_team_goal ~ "Away Win",
    TRUE ~ "Draw"
  ))


library(ggplot2)

# Possession vs Result
ggplot(merged, aes(x = homepos - awaypos, fill = result)) +
  geom_histogram(binwidth = 2, position = "identity", alpha = 0.6) +
  labs(title = "Home Possession Advantage vs Match Result",
       x = "Home Possession - Away Possession (%)",
       y = "Number of Matches") +
  theme_minimal()
