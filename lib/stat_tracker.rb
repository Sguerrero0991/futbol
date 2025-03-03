require 'CSV'
class StatTracker 
  def initialize

  end

  def self.from_csv(locations)
    # Open and read the CSV file, then return the data (this can be an array of rows)
    CSV.read(locations, headers: true)
  end
end
