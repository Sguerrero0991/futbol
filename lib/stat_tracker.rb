require 'CSV'
class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(locations)
    @games = locations[:games]
    @teams = locations[:teams]
    @game_teams = locations[:game_teams]
    # binding.pry
  end
  def self.from_csv(locations)
    puts "Locations Hash: #{locations.inspect}"
    # Read each CSV file using the correct paths
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    # Create a new instance of StatTracker
    stat_tracker = StatTracker.new(locations)
    # Return the instance
    # binding.pry 
    return stat_tracker
  end
end