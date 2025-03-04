require 'simplecov'
SimpleCov.start
#require 'CSV'
require './lib/stat_tracker'
require './lib/season_statistics'
locations = './data/game_teams.csv'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe 'Season_Statistics'

describe '#initialize' do
  it 'exists' do
  @season_statistics = SeasonStatistics.new
  expect(@season_statistics).to be_an_instance_of(SeasonStatistics)
  end
end
describe '#attributes' do
    xit '#winningest_coach' do
      expect().to
    end
    xit 'worst_coach' do
      expect().to
    end
    xit 'most_accurate_team' do
      expect().to
    end
    xit 'least_accurate_team' do
      expect().to
    end
    xit 'most_tackles' do
      expect().to
    end
    xit 'fewest_tackles' do
      expect().to
    end
end  