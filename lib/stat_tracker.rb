require 'CSV'
class StatTracker
  def initialize(games,teams,game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
  def self.from_csv(locations)
    # Read each CSV file using the correct paths
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    # Create a new instance of StatTracker
    stat_tracker = StatTracker.new(games, teams, game_teams)
    # Return the instance
    return stat_tracker
  end
end
