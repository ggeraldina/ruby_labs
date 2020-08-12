# The class for planning a point-to-point route
class Route
  attr_reader :points, :parents, :queue, :dep_point, :arr_point

  def initialize(points, dep_point, arr_point)
    @points = points
    @dep_point = dep_point
    @arr_point = arr_point
  end

  def show_route
    # Check on the match of the point of departure of the train
    # and the point of arrival of the train
    if @dep_point == @arr_point
      puts 'Route: ', @dep_point
      return
    end
    @parents = { @dep_point => 'start' }
    @queue = [@dep_point]
    loop do
      break if @queue.empty?

      tmp_point = @queue.shift
      next unless @points.key?(tmp_point)

      return if check_nearby_points(tmp_point)
    end
    puts 'There is no a route from ' + @dep_point + ' to ' + @arr_point
  end

  # relate to show_route
  def check_nearby_points(tmp_point)
    @points[tmp_point].each do |train|
      unless @parents.key?(train.arrival_point)
        @queue.push(train.arrival_point)
        @parents[train.arrival_point] = tmp_point
      end
      if train.arrival_point == @arr_point
        print_route(@arr_point)
        return true
      end
    end
    false
  end

  # relate to check_nearby_points
  def print_route(str)
    # pp @parents
    end_point = @parents[str]
    until @parents[end_point] == 'start'
      str = end_point + ' -> ' + str
      end_point = @parents[end_point]
    end
    puts 'Route: ', end_point + ' -> ' + str
  end
end
