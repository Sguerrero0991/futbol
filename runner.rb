require_relative './lib/stat_tracker'
require './lib/games'
require 'pry'
require 'csv'

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

puts stat_tracker.highest_total_score
puts stat_tracker.lowest_total_score
puts stat_tracker.percentage_home_wins
puts stat_tracker.percentage_visitor_wins
puts stat_tracker.percentage_ties
# puts stat_tracker.count_of_games_by_season
puts stat_tracker.highest_scoring_visitor
puts stat_tracker.highest_scoring_home_team
puts stat_tracker.lowest_scoring_visitor
puts stat_tracker.lowest_scoring_home_team
puts stat_tracker.winningest_coach("20132014")
puts stat_tracker.winningest_coach("20142015")
puts stat_tracker.worst_coach("20132014")
puts stat_tracker.worst_coach("20142015")
puts stat_tracker.most_accurate_team("20132014")
puts stat_tracker.most_accurate_team("20142015")
puts stat_tracker.least_accurate_team("20132014")
puts stat_tracker.least_accurate_team("20142015")
puts stat_tracker.most_tackles("20132014")
puts stat_tracker.most_tackles("20142015")
puts stat_tracker.fewest_tackles("20132014")
puts stat_tracker.fewest_tackles("20142015")
puts "Best team ID: #{best_team_id}"
puts "Best team: #{best_team.inspect}"