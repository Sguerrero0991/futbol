require 'csv'
require 'pry'
class Teams
  attr_reader :team_id, 
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(team_data)
    @team_id = team_data[:team_id].to_i
    @franchise_id = team_data[:franchiseid].to_i
    @team_name = team_data[:teamname]
    @abbreviation = team_data[:abbreviation]
    @stadium = team_data[:stadium]
    @link = team_data[:link]
  end

  def team_id
    @team_id
  end

  def franchise_id
    @franchise_id
  end

  def team_name
    @team_name
  end

  def abbreviation
    @abbreviation
  end

  def stadium
    @stadium
  end

  def link
    @link
  end
end


