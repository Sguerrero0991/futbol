class GameStatistics

  def initalize ()
  end

  def highest_total_score(games)
      games.map{game[:away_goals.to_i] + game[:home_goals.to_i]}
  end


end