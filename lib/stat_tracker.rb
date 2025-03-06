require 'CSV'
require 'pry'
# require './lib/games'
class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    
  end
 
  def self.from_csv(locations)
    # Read each CSV file using the correct paths
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol).map(&:to_h)
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol).map(&:to_h)
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol).map(&:to_h)
    # Create a new instance of StatTracker
    new(games, teams, game_teams)
  end
end