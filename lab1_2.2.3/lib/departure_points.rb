require_relative 'route'

# The class with data from a database.
# @points - a hash, where a point of departure
# points to trains from this point
class DeparturePoints
  attr_reader :points

  def initialize
    @points = {}
  end

  def add_train(dep_point, train)
    if @points.key?(dep_point)
      # Check on 100% of the presence of such a train
      @points[dep_point] = @points[dep_point].push(train) unless @points[dep_point].include?(train)
    else
      @points[dep_point] = [train]
    end
  end

  def remove_train(dep_point, remove_train)
    return false unless @points.key?(dep_point)

    if @points[dep_point].size > 1
      result = @points[dep_point].reject! { |train| remove_train == train }
      result.nil? ? false : true
    else
      @points.delete(dep_point)
      true
    end
  end

  def show_route(dep_point, arr_point)
    route = Route.new(@points, dep_point, arr_point)
    route.show_route
  end

  def print_train_dep_point_arr_time(dep_point, arr_time)
    return unless @points.key?(dep_point)

    @points[dep_point].each do |train|
      puts train if train.arrival_time == arr_time
    end
  end

  def print_train_dep_point_arr_point(dep_point, arr_point)
    return unless @points.key?(dep_point)

    @points[dep_point].each do |train|
      puts train if train.arrival_point == arr_point
    end
  end
end
