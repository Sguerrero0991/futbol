require 'csv'
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
  
  def count_of_games_by_season
    #create a hash to store season counts
    season_counts = Hash.new(0) #will ensure that any new season gets a default value of 0.

    @games.each do |game| #iterates thru the games array 
      season_counts[game.season.to_s] += 1  #increment the count of games for each season.
    end
    season_counts #return the hash of season counts
  end

  def average_goals_per_game
    total_goals = 0
    total_games = 0

    @games.each do |game|
      total_goals += game.home_goals + game.away_goals
      total_games += 1
    end

    (total_goals.to_f / total_games).round(2)
  end

  def average_goals_by_season
    season_goals = Hash.new(0)  #Hash to store total goals per season
    season_games = Hash.new(0)  #Hash to store total games per season

    @games.each do |game|
      season_goals[game.season] += game.home_goals + game.away_goals
      season_games[game.season] += 1
    end

    average_goals = {} # Hash to store final averages

    season_goals.each do |season, total_goals|
      average_goals[season.to_s] = (total_goals.to_f / season_games[season]).round(2)
    end

    average_goals
  end
  
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
    best_team_id = team_goals.max_by { |team_id, goals| goals }[0] 
    best_team = @teams.find { |team| team.team_id == best_team_id }
    best_team.team_name
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

    # team_goals.each do |team_id, goals|

    # end

    worst_team_id = team_goals.min_by { |team_id, goals| goals }[0]
    worst_team = @teams.find { |team| team.team_id == worst_team_id }
    worst_team.team_name
  end 

  def highest_scoring_visitor
    #1: Filter game_teams to only include away games
    away_games = @game_teams.select { |game_team| game_team.hoa == 'away' }

    #2: Group away_games by team_id
    away_teams = away_games.group_by { |game_team| game_team.team_id }

    #3: Calculate the average goals for each team
    team_averages = away_teams.map do |team_id, games|
      total_goals = games.sum { |game| game.goals.to_i }
        average_goals = total_goals.to_f / games.size
          [team_id, average_goals]
    end


    #4: Find the team with the highest average goals
    highest_avg_team_id = team_averages.max_by { |team_id, avg| avg }[0]

    #5: Find the team name by team_id
    team = @teams.find { |team| team.team_id == highest_avg_team_id }
    team.team_name
  end

  def highest_scoring_home_team
    #1: Filter game_teams to only include home games 
    home_games = @game_teams.select { |game_team| game_team.hoa == 'home' }

    #2: Group home_games by team_id
    home_teams = home_games.group_by { |game_team| game_team.team_id }

    #3: Calculate the average goals for each team
    team_averages = home_teams.map do |team_id, games|
      total_goals = games.sum { |game| game.goals.to_i }
        average_goals = total_goals.to_f / games.size
        [team_id, average_goals]
    end

    #4: Find the team with the highest average goals
    highest_avg_team_id = team_averages.max_by { |team_id, avg| avg }[0]

    #5: Find the team name by team_id
    team = @teams.find { |team| team.team_id == highest_avg_team_id }
    team.team_name
  end

  def lowest_scoring_visitor
    #1: Filter game_teams to only include away games
    away_games = @game_teams.select { |game_team| game_team.hoa == 'away' }

    #2: Group away_games by team_id
    away_teams = away_games.group_by { |game_team| game_team.team_id }

    #3: Calculate the average goals for each team
    team_averages = away_teams.map do |team_id, games|
      total_goals = games.sum { |game| game.goals.to_i }
        average_goals = total_goals.to_f / games.size
          [team_id, average_goals]
    end

    #4: Find the team with the lowest average goals
    lowest_avg_team_id = team_averages.min_by { |team_id, avg| avg }[0]

    #5: Find the team name by team_id
    team = @teams.find { |team| team.team_id == lowest_avg_team_id }
    team.team_name
  end

  def lowest_scoring_home_team
    #1: Filter game_teams to only include home games
    home_games = @game_teams.select { |game_team| game_team.hoa == 'home' }

    #2: Group home_games by team_id
    home_teams = home_games.group_by { |game_team| game_team.team_id }

    #3: Calculate the average goals for each team
    team_averages = home_teams.map do |team_id, games|
      total_goals = games.sum { |game| game.goals.to_i }
        average_goals = total_goals.to_f / games.size
          [team_id, average_goals]
    end

    #4: Find the team with the lowest average goals
    lowest_avg_team_id = team_averages.min_by { |team_id, avg| avg }[0]
    
    #5: Find the team name by team_id
    team = @teams.find { |team| team.team_id == lowest_avg_team_id }
    team.team_name
  end

  def winningest_coach(season)
    #1: Get game_ids for the given season
    season_game_ids = @games.select { |game| game.season.to_s == season }.map{ |game| game.game_id }
  
    #2: Filter game_teams to only include those game_ids
    season_game_teams = @game_teams.select { |game_team| season_game_ids.include?(game_team.game_id) }
  
    #3: Group by coach and calculate win percentage
    coach_stats = Hash.new { |hash, key| hash[key] = { total_games: 0, wins: 0 } }
  
    season_game_teams.each do |game_team|
      coach = game_team.head_coach
      coach_stats[coach][:total_games] += 1
      coach_stats[coach][:wins] += 1 if game_team.result == "WIN"
    end
  
    #4: Determine the coach with the highest win percentage
    coach_stats.max_by { |coach, stats| stats[:wins].to_f / stats[:total_games] }.first
  end

  def worst_coach(season)
    #1: Get game_ids for the given season
    season_game_ids = @games.select { |game| game.season.to_s == season }.map{ |game| game.game_id }
  
    #2: Filter game_teams to only include those game_ids
    season_game_teams = @game_teams.select { |game_team| season_game_ids.include?(game_team.game_id) }
  
    #3: Group by coach and calculate win percentage
    coach_stats = Hash.new { |hash, key| hash[key] = { total_games: 0, wins: 0 } }
  
    season_game_teams.each do |game_team|
      coach = game_team.head_coach
      coach_stats[coach][:total_games] += 1
      coach_stats[coach][:wins] += 1 if game_team.result == "WIN"
    end
  
    #4: Determine the coach with the lowest win percentage
    coach_stats.min_by { |coach, stats| stats[:wins].to_f / stats[:total_games] }.first
  end

  def most_accurate_team(season)
    #1: Get game_ids for the given season
    season_game_ids = @games.select { |game| game.season.to_s == season }.map{ |game| game.game_id }
  
    #2: Filter game_teams for the given season
    season_game_teams = @game_teams.select { |game_team| season_game_ids.include?(game_team.game_id) }
  
    #3: Group by team_id and calculate total goals and shots
    team_shot_accuracy = Hash.new { |hash, key| hash[key] = { goals: 0, shots: 0 } }
  
    season_game_teams.each do |game_team|
      team_shot_accuracy[game_team.team_id][:goals] += game_team.goals
      team_shot_accuracy[game_team.team_id][:shots] += game_team.shots
    end
  
    #4: Find the team with the highest shot accuracy (goals/shots)
    most_accurate_team_id = team_shot_accuracy.max_by { |team_id, stats| stats[:goals].to_f / stats[:shots] }.first
  
    #5: Find the team name using team_id
    @teams.find { |team| team.team_id == most_accurate_team_id }.team_name
  end

  def least_accurate_team(season)
    #1: Get game_ids for the given season
    season_game_ids = @games.select { |game| game.season.to_s == season }.map{ |game| game.game_id }
  
    #2: Filter game_teams for the given season
    season_game_teams = @game_teams.select { |game_team| season_game_ids.include?(game_team.game_id) }
  
    #3: Group by team_id and calculate total goals and shots
    team_shot_accuracy = Hash.new { |hash, key| hash[key] = { goals: 0, shots: 0 } }
  
    season_game_teams.each do |game_team|
      team_shot_accuracy[game_team.team_id][:goals] += game_team.goals
      team_shot_accuracy[game_team.team_id][:shots] += game_team.shots
    end
  
    #4: Find the team with the lowest shot accuracy (goals/shots)
    least_accurate_team_id = team_shot_accuracy.min_by { |team_id, stats| stats[:goals].to_f / stats[:shots] }.first
  
    #5: Find the team name using team_id
    @teams.find { |team| team.team_id == least_accurate_team_id }.team_name
  end

  def most_tackles(season)
    #1: Get game_ids for the given season
    season_game_ids = @games.select { |game| game.season.to_s == season }.map{ |game| game.game_id }
  
    #2: Filter game_teams for the given season
    season_game_teams = @game_teams.select { |game_team| season_game_ids.include?(game_team.game_id) }
  
    #3: Group by team_id and sum up tackles
    team_tackles = Hash.new(0)
  
    season_game_teams.each do |game_team|
      team_tackles[game_team.team_id] += game_team.tackles
    end
  
    #4: Find the team with the most tackles
    most_tackles_team_id = team_tackles.max_by { |team_id, tackles| tackles }.first
  
    #5: Find the team name using team_id
    @teams.find { |team| team.team_id == most_tackles_team_id }.team_name
  end

  def fewest_tackles(season)
    #1: Get game_ids for the given season
    season_game_ids = @games.select { |game| game.season.to_s == season }.map{ |game| game.game_id }
  
    #2: Filter game_teams for the given season
    season_game_teams = @game_teams.select { |game_team| season_game_ids.include?(game_team.game_id) }
  
    #3: Group by team_id and sum up tackles
    team_tackles = Hash.new(0)
  
    season_game_teams.each do |game_team|
      team_tackles[game_team.team_id] += game_team.tackles
    end
  
    #4: Find the team with the fewest tackles
    fewest_tackles_team_id = team_tackles.min_by { |team_id, tackles| tackles }.first
  
    #5: Find the team name using team_id
    @teams.find { |team| team.team_id == fewest_tackles_team_id }.team_name
  end
 
end