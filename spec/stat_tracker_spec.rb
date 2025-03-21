require '../futbol/lib/stat_tracker'
require 'csv'
require 'pry'

RSpec.describe StatTracker do
  before(:each) do
    # Convert local variables to instance variables
    @games_path = './data/games.csv'
    @teams_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @games_path,
      teams: @teams_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end

  describe 'from_csv' do
    it 'reads the correct CSV files' do
      # Now @locations and @games_path are properly set in before(:each)
      stat_tracker = StatTracker.from_csv(@locations)
      games = CSV.read(@games_path, headers: true, header_converters: :symbol)
      expect(games).not_to be_empty
      expect(games.headers).to include(:game_id, :season, :home_team_id)
    end

    it 'creates StatTracker with the correct data' do
      allow(CSV).to receive(:read).with(@locations[:games], headers: true, header_converters: :symbol).and_return([
        { game_id: "2012030221", season: "20122013", home_team_id: "6", away_team_id: "3" },
        { game_id: "2012030222", season: "20122013", home_team_id: "4", away_team_id: "1" }
      ])
      allow(CSV).to receive(:read).with(@locations[:teams], headers: true, header_converters: :symbol).and_return([
        { team_id: 1, team_name: 'Team A', abbreviation: 'TA' },
        { team_id: 2, team_name: 'Team B', abbreviation: 'TB' }
      ])
      allow(CSV).to receive(:read).with(@locations[:game_teams], headers: true, header_converters: :symbol).and_return([
        { game_id: "2012030221", team_id: 3, hoa: 'home' },
        { game_id: "2012030222", team_id: 1, hoa: 'away' }
      ])
      stat_tracker = StatTracker.from_csv(@locations)
  
      expect(stat_tracker.games).to all(be_an_instance_of(Games))
      expect(stat_tracker.teams).to all(be_an_instance_of(Teams))
      expect(stat_tracker.game_teams).to all(be_an_instance_of(GameTeams))
    end

    it 'reads the CSV data correctly and initializes the correct objects' do
      stat_tracker = StatTracker.from_csv(@locations)
      games_first_row = stat_tracker.games.first
      expect(games_first_row).to have_attributes(
        game_id: be_a(Integer),
        season: be_a(Integer),
        type: be_a(String),
        date_time: be_a(String),
        home_team_id: be_a(Integer),
        away_team_id: be_a(Integer),
        away_goals: be_a(Integer),
        home_goals: be_a(Integer),
        venue: be_a(String),
        venue_link: be_a(String)
      )
      # binding.pry
    end

    it "#highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 11
    end

    it "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 0
    end

    it "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.44
    end

    it "#percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
    end

    it '#percentage_ties' do
    expect(@stat_tracker.percentage_ties).to eq 0.20
    end

    it "#count_of_games_by_season" do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }

    expect(@stat_tracker.count_of_games_by_season).to eq expected
    end 
  end

  it "#average_goals_per_game" do
    expect(@stat_tracker.average_goals_per_game).to eq 4.22
  end

  it "#average_goals_by_season" do
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    expect(@stat_tracker.average_goals_by_season).to eq expected
  end

  it "#count_of_teams" do
    expect(@stat_tracker.count_of_teams).to eq 32
  end
  
  it "#best_offense" do
    expect(@stat_tracker.best_offense).to eq "Reign FC"
  end

  it "#worst_offense" do
    expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  end

  it "#highest_scoring_visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  end

  it "#highest_scoring_home_team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  end

  it "#lowest_scoring_visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  it "#lowest_scoring_home_team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  end

  # it "#team_info" do
  #   expected = {
  #     "team_id" => "18",
  #     "franchise_id" => "34",
  #     "team_name" => "Minnesota United FC",
  #     "abbreviation" => "MIN",
  #     "link" => "/api/v1/teams/18"
  #   }

  #   expect(@stat_tracker.team_info("18")).to eq expected
  # end

  # it "#best_season" do
  #   expect(@stat_tracker.best_season("6")).to eq "20132014"
  # end

  # it "#worst_season" do
  #   expect(@stat_tracker.worst_season("6")).to eq "20142015"
  # end

  # it "#average_win_percentage" do
  #   expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
  # end

  # it "#most_goals_scored" do
  #   expect(@stat_tracker.most_goals_scored("18")).to eq 7
  # end

  # it "#fewest_goals_scored" do
  #   expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
  # end

  # it "#favorite_opponent" do
  #   expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
  # end

  # it "#rival" do
  #   expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  # end

  it "#winningest_coach" do
    expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
    expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
  end

  it "#worst_coach" do
    expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
    expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  it "#most_accurate_team" do
    expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  it "#least_accurate_team" do
    expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  it "#most_tackles" do
    expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  it "#fewest_tackles" do
    expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
  end
end
