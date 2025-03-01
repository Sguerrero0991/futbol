require_relative './lib/stat_tracker'
require 'pry'
require 'CSV'

CSV.foreach('./data/games.csv', headers: true, header_converters: :symbol) do |row|
  puts row[:game_id] # Access column by header name
  puts row[0]    # Access column by index
  game_id,
  season,
  type,
  date_time,
  away_team_id,
  home_team_id,
  away_goals,
  home_goals,
  venue,venue_link
end 

CSV.foreach('./data/teams.csv', headers: true, header_converters: :symbol) do |row|
  puts row['Name'] # Access column by header name
  puts row[0]    # Access column by index
end 

CSV.foreach('./data/game_teams.csv', headers: true, header_converters: :symbol) do |row|
  puts row['Name'] # Access column by header name
  puts row[0]    # Access column by index
end 

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
binding.pry
stat_tracker = StatTracker.from_csv(locations)


