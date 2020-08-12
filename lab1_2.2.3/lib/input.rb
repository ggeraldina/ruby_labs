require_relative 'check'

# The module for receiving input data
module Input
  def self.read_action
    action = gets
    if action.nil?
      print "\nPressed ctrl-D\nNote: the result of the program is not saved\n"
      exit 0
    end
    action.chomp
  end

  def self.read_train
    departure_time = read_departure_time
    arrival_point = read_arrival_point
    arrival_time = read_arrival_time
    number = read_number
    price = read_price
    Train.new(arrival_point, arrival_time, departure_time, number, price)
  end

  def self.read_arrival_point
    loop do
      puts 'Enter the arrival point of the train, please'
      arrival_point = gets
      read_arrival_point if arrival_point.nil?
      arrival_point = arrival_point.chomp
      return arrival_point if Check.verify_point(arrival_point)
    end
  end

  def self.read_arrival_time
    loop do
      puts 'Enter the arrival time of the train, please'
      arrival_time = gets
      read_arrival_time if arrival_time.nil?
      arrival_time = arrival_time.chomp
      return arrival_time if Check.verify_time(arrival_time)
    end
  end

  def self.read_departure_point
    loop do
      puts 'Enter the departure point of the train, please'
      departure_point = gets
      read_departure_point if departure_point.nil?
      departure_point = departure_point.chomp
      return departure_point if Check.verify_point(departure_point)
    end
  end

  def self.read_departure_time
    loop do
      puts 'Enter the departure time of the train, please'
      departure_time = gets
      read_departure_time if departure_time.nil?
      departure_time = departure_time.chomp
      return departure_time if Check.verify_time(departure_time)
    end
  end

  def self.read_number
    loop do
      puts 'Enter the number of the train, please'
      number = gets
      read_number if number.nil?
      number = number.chomp
      return number if Check.verify_number(number)
    end
  end

  def self.read_price
    loop do
      puts 'Enter the price of the train, please'
      price = gets
      read_price if price.nil?
      price = price.chomp
      return price if Check.verify_price(price)
    end
  end
end
