require 'CSV'
class StatTracker 
  def initialize

  end

  def self.from_csv(file_path)
    # Open and read the CSV file, then return the data (this can be an array of rows)
    CSV.read(file_path, headers: true)
  end
end
