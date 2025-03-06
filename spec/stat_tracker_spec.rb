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

  it 'stores csv data in and array of hashs' do
    expect(@stat_tracker.games).to be_an(Array)
    expect(@stat_tracker.teams).to be_an(Array)
    expect(@stat_tracker.game_teams).to be_an(Array)

    expect(@stat_tracker.games.first).to be_a(Hash)
    expect(@stat_tracker.teams.first).to be_a(Hash)
    expect(@stat_tracker.game_teams.first).to be_a(Hash)
  end 

  it 'has correct keys in game data' do
    expect(@stat_tracker.games.first.keys).to include(:game_id, :season, :home_team_id, :away_team_id)
  end

  it 'has correct keys in team data' do
    expect(@stat_tracker.teams.first.keys).to include(:team_id, :teamname)
  end

  it 'has correct keys in game_teams data' do
    expect(@stat_tracker.game_teams.first.keys).to include(:game_id, :team_id, :hoa)
  end
end
