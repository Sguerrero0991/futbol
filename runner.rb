require_relative './lib/stat_tracker'
require 'pry'
require 'CSV'

game_path = './data/games.txt'
team_path = './data/teams.txt'
game_teams_path = './data/game_teams.txt'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
# binding.pry
stat_tracker = StatTracker.from_csv(locations)