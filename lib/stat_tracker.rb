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
    @games.map { |game| game.home_goals.to_i + game.away_goals.to_i }.max
  end

  def lowest_total_score
    @games.map {|game| game.home_goals + game.away_goals }.min
  end

  def percentage_home_wins
    total_games = @games.length.to_f
    home_wins = @games.count { |game| game.home_goals.to_i > game.away_goals.to_i }
  
    (home_wins / total_games).round(2)
  end

  def percentage_visitor_wins
    total_games = @games.length.to_f
    away_wins = @games.count {|game| game.home_goals.to_i < game.away_goals.to_i}

    (away_wins / total_games).round(2)
  end

  def percentage_ties
    total_games = @games.length.to_f
    ties = @games.count {|game| game.home_goals.to_i == game.away_goals.to_i}

    (ties / total_games).round(2)
  end

  # def count_of_games_by_season
  #   hash = {}
  #   @games.each do |season|
  #     hash[:season] = []
  #     @games.count
  #   end
  # end
  def count_of_teams
    @teams.count
  end

  def best_offense
    team_goals = Hash.new(0)
  
    @games.each do |game|
      home_team_id = game.home_team_id.to_s
      away_team_id = game.away_team_id.to_s
      home_goals = game.home_goals.to_i
      away_goals = game.away_goals.to_i
  
      team_goals[home_team_id] += home_goals
      team_goals[away_team_id] += away_goals
    end
    worst_team_id = team_goals.min_by { |team_id, goals| goals }[0]
    worst_team = @teams.find { |team| team.team_id == worst_team_id }
    worst_team.team_name
  end

  def worst_offense
    team_goals = Hash.new(0)
    @games.each do |game|
      home_team_id = game.home_team_id.to_s
      away_team_id = game.away_team_id.to_s
      home_goals = game.home_goals.to_i
      away_goals = game.away_goals.to_i
      team_goals[home_team_id] += home_goals
      team_goals[away_team_id] += away_goals
    end
    team_goals.each do |team_id, goals|
    end
    worst_team_id = team_goals.min_by { |team_id, goals| goals }[0]
    worst_team = @teams.find { |team| team.team_id == worst_team_id }
    worst_team.team_name
  end
end