require_relative './spec_helper'
require './lib/game_statistics'
require './lib/stat_tracker'

#require 'CSV'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe GameStatistics do
  before(:each) do
    @stat_tracker = StatTracker.new
    @gamestatistics = GameStatistics.new
  end

  describe '#initalize' do 
  it 'exists' do
      expect(@gamestatistics).to be_an_instance_of(GameStatistics)
    end
  end

  describe '#attributes' do
    it 'can determine highest_total_score' do
      
      expect(@stat_tracker.highest_total_score).to eq[5]
    end

    xit 'can determine lowest_total_score' do
      expect
    end

    xit 'can determine percentage_home_wins' do
      expect
    end

    xit 'can determine percentage_visitor_wins' do
      expect
    end

    xit 'can determine percentage_ties' do
      expect
    end

    xit 'can determine count_of_games_by_season' do
      expect
    end

    xit 'can determine average_goals_per_game' do
      expect
    end

    xit 'can determine average_goals_by_season' do
      expect
    end
  end
  
end