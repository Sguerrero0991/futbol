require_relative './lib/stat_tracker'
require 'pry'
require 'CSV'

# CSV.foreach('./data/games.txt', headers: true, header_converters: :symbol) do |row|
#    row[0]    # Access column by index
#    season = row[:season].to_i
#    game_id = row[:game_id] # Access column by header name
#    type = row[:type]
#    date_time = row[:date_time]
#    away_team_id = row[:away_team_id]
#    home_team_id = row[:home_team_id]
#    away_goals = row[:away_goals]
#    home_goals = row[:home_goals]
#    venue = row[:venue]
#    venue_link = row[:venue_link]
# end 

CSV.foreach('./data/teams.txt', headers: true, header_converters: :symbol) do |row|
  team_id = row[:team_id]
  franchiseid = row[:franchiseid]
  teamName = row[:teamName]
  abbreviation = row[:abbreviation]
  stadium = row[:stadium]
  link = row[:link]

end

# CSV.foreach('./data/game_teams.csv', headers: true, header_converters: :symbol) do |row|
#   puts row['Name'] # Access column by header name
#   puts row[0]    # Access column by index
# end 

game_path = './data/games.txt'
team_path = './data/teams.txt'
game_teams_path = './data/game_teams.txt'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
binding.pry
stat_tracker = StatTracker.from_csv(locations)


