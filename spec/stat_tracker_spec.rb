require '../futbol/lib/stat_tracker'
require 'pry'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
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

  
  binding.pry
end 
