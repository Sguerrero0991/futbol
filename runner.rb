require_relative './lib/stat_tracker'
require 'pry'
require 'CSV'

games_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: games_path,
  teams: team_path,
  game_teams: game_teams_path
}
# binding.pry
stat_tracker = StatTracker.from_csv(locations)