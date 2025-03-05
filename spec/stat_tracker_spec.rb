require '../futbol/lib/stat_tracker'
require 'csv'
require 'pry'

RSpec.describe StatTracker do
  before(:each) do
    # Convert local variables to instance variables
    @games_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @games_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end

  it 'stores a file path of games in a hash' do
    expect(@stat_tracker.games).to eq(@games_path)
  end 

  it 'stores a file path of teams in a hash' do
    expect(@stat_tracker.teams).to eq(@team_path)
  end 

  it 'stores a file path of game_teams in a hash' do
    expect(@stat_tracker.game_teams).to eq(@game_teams_path)
  end 

  describe 'from_csv' do
    it 'reads the correct CSV files' do
      # Now @locations and @games_path are properly set in before(:each)
      stat_tracker = StatTracker.from_csv(@locations)

      games = CSV.read(@games_path, headers: true, header_converters: :symbol)

      expect(games).not_to be_empty
      expect(games.headers).to include(:game_id, :season, :home_team_id)
    end
  end
end
