require '../futbol/lib/stat_tracker'
require 'pry'

RSpec.describe StatTracker do
  before(:all) do
    games_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: games_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it 'stores a file path of games in a hash' do
    expect(@stat_tracker.games).to eq('./data/games.csv')
  end 
 

  it 'stores a file path of teams in a hash' do
    expect(@stat_tracker.teams).to eq('./data/teams.csv')
  end 

  it 'stores a file path of game_teams in a hash' do
    expect(@stat_tracker.game_teams).to eq('./data/game_teams.csv')
  end 

  describe '.from_csv' do
    it 'reads the correct CSV files' do
      stat_tracker = StatTracker.from_csv(@locations)

      # Read the test CSV file manually to compare
      games = CSV.read(@games_path, headers: true, header_converters: :symbol)

      # Check if the CSV was read correctly
      expect(games).not_to be_empty
      expect(games.headers).to include(:game_id, :season, :home_team_id) # Adjust based on actual headers
      
    end
  end
  binding.pry
end 
