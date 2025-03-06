require 'csv'
require 'pry'
class Games
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :home_team_id,
              :away_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link
  def initialize(locations)
    # @game_id = data[:game_id]
    # @season = data[:season]
    # @type = data[:type]
    # @date_time = data[:date_time]
    # @away_team_id = data[:away_team_id]
    # @home_team_id = data[:home_team_id]
    # @away_goals = data[:away_goals]
    # @home_goals = data[:home_goals]
    # @venue = data[:venue]
    # @venue_link = data[:venue_link]
  end

  # def self.from_csv(locations)
  #   games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
  # end

  # def 
  #   stat_tracker = StatTracker.new(locations)
  # end 
  # binding.pry
  # def highest_total_score

  # end 
    
  #   Highest sum of the winning and losing teams’ scores	Integer
end