require 'CSV'
require 'pry'
require_relative './games'
require_relative './team'
require_relative './game_teams'
class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    
  end
 
  def self.from_csv(locations)
    # Read each CSV file using the correct paths
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol).map { |row| Games.new(row) }
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol).map { |row| Teams.new(row) }    
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol) { |row| Games_Teams.new(row) }
    # Create a new instance of StatTracker
    new(games, teams, game_teams)
  end
end