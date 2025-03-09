require 'csv'
require 'pry'
  attr_reader :game_id,
              :team_id,
              :HoA,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :powerPlayOpportunities,
              :powerPlayGoals,
              :faceOffWinPercentage,
              :giveaways,
              :takeaways

  def initialize(data)
      @game_id = data[:game_id].to_i
      @team_id = data[:team_id].to_i
      @hoa =  data[:hoa]
      @result = data[:result]
      @settled_in = data[:settled_in]
      @head_coach = data[:head_coach]
      @goals = data[:goals].to_i
      @shots = data[:shots].to_i
      @tackles = data[:tackles].to_i
      @pim = data[:pim].to_i
      @powerPlayOpportunities = data[:powerPlayOpportunities].to_i
      @powerPlayGoals = data[:powerPlayGoals].to_i
      @faceOffWinPercentage = data[:faceOffWinPercentage].to_i
      @giveaways = data[:giveaways].to_i
      @takeaways = data[:takeaways].to_i
  end

  def game_id
    @game_id
  end

  def team_id
    @team_id
  end

  def hoa
    @hoa
  end

  def result
    @result
  end

  def settled_in
    @settled_in
  end

  def head_coach
    @head_coach
  end

  def goals
    @goals
  end

  def shots
    @shots
  end
  
  def tackles
    @tackles
  end

  def pim
    @pim
  end

  def powerPlayOpportunities
    @powerPlayOpportunities
  end

  def powerPlayGoals
    @powerPlayGoals
  end

  def faceOffWinPercentage
    @faceOffWinPercentage 
  end

  def giveaways
    @giveaways
  end

  def takeaways
    @takeaways
  end
end

