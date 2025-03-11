require_relative './lib/stat_tracker'
require './lib/games'
require 'pry'
require 'csv'
require 'colorize'

games_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: games_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
# binding.pry

puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
puts "| Highest Total Score: #{stat_tracker.highest_total_score}                                                                                                                     |".blue
puts "| Lowest Total Score: #{stat_tracker.lowest_total_score}                                                                                                                       |".blue
puts "| Percentage Home Wins: #{stat_tracker.percentage_home_wins}                                                                                                                  |".blue
puts "| Percentage Visitor Wins: #{stat_tracker.percentage_visitor_wins}                                                                                                               |".blue
puts "| Percentage Ties: #{stat_tracker.percentage_ties}                                                                                                                        |".blue
puts "| Count of Games by season: #{stat_tracker.count_of_games_by_season}       |".blue
puts "| Average Goals per Game: #{stat_tracker.average_goals_per_game}                                                                                                                |".blue
puts "| Average Goals by Season: #{stat_tracker.average_goals_by_season}       |".blue
puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
puts "| Count of Teams: #{stat_tracker.count_of_teams}                                                                                                                          |".red
puts "| Best Offense: #{stat_tracker.best_offense}                                                                                                                      |".red
puts "| Worst Offense: #{stat_tracker.worst_offense}                                                                                                               |".red
puts "| Highest Scoring Visitor: #{stat_tracker.highest_scoring_visitor}                                                                                                          |".red
puts "| Highest Scoring Home Team: #{stat_tracker.highest_scoring_home_team}                                                                                                         |".red
puts "| Lowest Scoring Visitor: #{stat_tracker.lowest_scoring_visitor}                                                                                                |".red
puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
puts "| Lowest Scoring Home Team: #{stat_tracker.lowest_scoring_home_team}                                                                                                    |".green
puts "| Winningest Coach 2014: #{stat_tracker.winningest_coach("20132014")}                                                                                                        |".green
puts "| Winningest Coach 2015: #{stat_tracker.winningest_coach("20142015")}                                                                                                      |".green
puts "| Worst Coach 2014: #{stat_tracker.worst_coach("20132014")}                                                                                                          |".green
puts "| Worst Coach 2015: #{stat_tracker.worst_coach("20142015")}                                                                                                                 |".green
puts "| Most Accurate Team 2014: #{stat_tracker.most_accurate_team("20132014")}                                                                                                     |".green
puts "-----------------------------------------------------------------------------------------------------------------------------------------------"
puts "| Most Accurate Team 2015: #{stat_tracker.most_accurate_team("20142015")}                                                                                                         |".magenta
puts "| Least Accurate Team 2014: #{stat_tracker.least_accurate_team("20132014")}                                                                                                  |".magenta
puts "| Least Accurate Team 2015: #{stat_tracker.least_accurate_team("20142015")}                                                                                                  |".magenta
puts "| Most Tackles 2014: #{stat_tracker.most_tackles("20132014")}                                                                                                            |".magenta
puts "| Most Tackles 2015: #{stat_tracker.most_tackles("20142015")}                                                                                                      |".magenta
puts "| Fewest Tackles 2014: #{stat_tracker.fewest_tackles("20132014")}                                                                                                         |".magenta
puts "| Fewest Tackles 2015: #{stat_tracker.fewest_tackles("20142015")}                                                                                                        |".magenta
puts "| \u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}\u{1f600}                                                                                                    |".magenta
puts "-----------------------------------------------------------------------------------------------------------------------------------------------"