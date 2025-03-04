require 'CSV'
class StatTracker
  def self.from_csv(locations)
    # Read each CSV file using the correct paths
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    # Print out the counts of the loaded data
    puts "Games loaded: #{games.count}"
    puts "Teams loaded: #{teams.count}"
    puts "GameTeams loaded: #{game_teams.count}"
    # Create a new instance of StatTracker
    stat_tracker = StatTracker.new(games, teams, game_teams)
    puts "StatTracker instance: #{stat_tracker.inspect}"
    # Return the instance
    return stat_tracker
  end
  def initialize()
  end
end
