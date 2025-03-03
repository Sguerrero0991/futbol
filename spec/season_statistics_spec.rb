require_relative './spec_helper'
require 'CSV'

RSpec.configure do |config|
  config.formatter = :documentation
end

CSV.foreach(StatTracker.from_csv(locations))

RSpec.describe Season_statistics

describe '#initialize' do
  it 'exisits' do
    expec(@Season_statistics).to be_an_instance(Season_statistics)
  end
end
describe '#attributes' do
    it '#winningest_coach' do
      expect().to
    end
    it 'worst_coach' do
      expect().to
    end
    it 'most_accurate_team' do
      expect().to
    end
    it 'least_accurate_team' do
      expect().to
    end
    it 'most_tackles' do
      expect().to
    end
    it 'fewest_tackles' do
      expect().to
    end
end  