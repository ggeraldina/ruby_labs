require 'csv'
require_relative 'train'
require_relative 'departure_points'
# Data Access Object (DAO)
# The module responsible for sending requests to the database
# and processing the responses received from it
module DAO
  PATH_INPUT = 'res/trains.csv'.freeze
  PATH_OUTPUT = 'res/trains_out.csv'.freeze

  def self.read_csv_data(filename = PATH_INPUT)
    departure_points = DeparturePoints.new
    CSV.foreach(filename, headers: true) do |row|
      train = Train.new(row['Arrival_point'], row['Arrival_time'],
                        row['Departure_time'], row['Number'], row['Price'])
      departure_points.add_train(row['Departure_point'], train)
    end
    departure_points
  rescue SystemCallError
    print "Loading the database...\nNo such file #{filename}\n"
    write_csv_data(DeparturePoints.new, filename)
    print "Such file created\n"
    read_csv_data(filename)
  end

  def self.write_csv_data(departure_points, filename = PATH_OUTPUT)
    CSV.open(filename, 'w') do |csv|
      csv << %w[Arrival_point Arrival_time Departure_point
                Departure_time Number Price]
      departure_points.points.each_pair do |dep_point, trains|
        trains.each do |train|
          csv << [train.arrival_point, train.arrival_time,
                  dep_point, train.departure_time,
                  train.number, train.price]
        end
      end
    end
  end
end
