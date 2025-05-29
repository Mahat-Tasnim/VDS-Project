# VDS-Project
The goal of the project is to assist the coaching staff in the identification of worthwhile player signings as well as the assessment of team performance trends and key variables affecting match outcomes — including possession levels, scoring, and discipline levels. The project translates raw match stats into useful insights by creating clear and informative visualizations in a bid to assist in informing future player bookings and match strategies.

Question 1:
Who are the up and coming promising players we can book for next year?

##Approach:

*Calculate the players performance rating

*Comparing attribute history

*Analyzing physical traits and readiness(2008-2016)

*Visualizing player perfomance rating

##Visualizations:
*Scatter Plot: The improvement in overall rating over time with the most recent overall rating which reflects the current skill level.

*Bubble Chart: Top growth potential

*Multi-line chart/Time Series Line Chart : Perform trand analysis over time

##For Run
*Promising_players.pdf / promising_players.Rmd


Question-2:
Which football teams improved the most in recent years?

##Approach:

*Computed per-season win percentages from match data.

*Calculated net win% change for each team (2008–2016).

*Visualized results with concise matplotlib plots.

##Visualizations:
*Lollipop chart: Top 10 and bottom 10 teams by net win% change.

*Bar chart: Top 20 improvers.

*Boxplots: League and season comparison.

*Line plot: Win% trends for top teams.

##For run:
*Open Team_Improvement_Analysis.ipynb.

*Ensure data files are present.

*Run all cells to generate all plots.

Question3 
 How important is possession to win games?

 *merged files match_possesion ,match_goals ,match csv files 
 
 *averaged the elapse for each teams in all matches
 
 *determined win/lose/draw results on  matches
 
 *possesions were aggrigated into categories
 
 Visualisations
 *bar charts overal relationship of possession and winning
 
 *dual bar charts showing the differences in the winning\lossing\drawing  rates of teams under different possessions
 
 *heat map the frequences of winning with high and low possession
 
 *stacked bars for the differences in winning rates agnaist possession of the teams in match
 
 ##for the run
 * possesion_influence_winning.html/ possesion_influence_winning.Rmd
 
 
