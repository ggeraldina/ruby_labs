# The class with data about a train
class Train
  attr_reader :arrival_point, :arrival_time, :departure_time, :number, :price

  def initialize(arrival_point, arrival_time, departure_time, number, price)
    @arrival_point = arrival_point
    @arrival_time = arrival_time
    @departure_time = departure_time
    @number = number
    @price = price
  end

  def ==(other)
    if (@arrival_point == other.arrival_point) &&
       (@arrival_time == other.arrival_time) &&
       (@departure_time == other.departure_time) &&
       (@number == other.number) &&
       (@price == other.price)
      true
    else
      false
    end
  end

  def to_s
    'Train № ' + number
  end
end
