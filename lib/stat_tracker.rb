require 'CSV'
require 'pry'
require_relative './games'
require_relative './teams'
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
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol).map do |row|
      Games.new(row) 
    end
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol).map do |row|
      Teams.new(row)
    end
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol).map do |row|
      GameTeams.new(row)
    end

    # Create a new instance of StatTracker
    # stat_tracker = StatTracker.new(locations)
    StatTracker.new(games, teams, game_teams)
    # Return the instance
  end
  
  def highest_total_score 
    games = StatTracker.new(games)
    games.map do |game| 
      game[:home_goals] + game[:away_goals].max
      
    end
    puts "#{stat_tracker.highest_total_score}"
    binding.pry
    #We need this method to, locate both away and home goals, [:away_goals] and [:homes goals]
    #add the sum of the two keys, 
    #and return the highest combination that the method finds in the CSV files
  end
end