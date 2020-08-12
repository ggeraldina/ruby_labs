require_relative 'dao'
require_relative 'input'
require_relative 'message'

# The base class
class Core
  attr_reader :departure_points

  def initialize
    @departure_points = DAO.read_csv_data
    Message.show_hello
    # pp @departure_points
    begin
      read_action
    rescue Interrupt
      print "\nPressed ctrl-C\nNote: the result of the program is not saved\n"
    rescue StandardError => e
      print "\nReceived Exception #{e}\n"
    end
    # pp @departure_points
  end

  def read_action
    loop do
      Message.show_actions
      action = Input.read_action
      case action
      when /^a$/, /^r$/ # add, remove
        read_action_add_remove(action)
      when /^p$/ # route planning
        read_action_plan
      when /^pt$/, /^pp$/ # print
        read_action_print(action)
      else # exit and save
        DAO.write_csv_data(@departure_points)
        break
      end
    end
  end

  def read_action_plan
    dep_point = Input.read_departure_point
    arr_point = Input.read_arrival_point
    @departure_points.show_route(dep_point, arr_point)
  end

  def read_action_add_remove(action)
    case action
    when /^a$/ # add
      departure_point = Input.read_departure_point
      @departure_points.add_train(departure_point, Input.read_train)
      puts 'Your train has been added to the database'
    when /^r$/ # remove
      read_action_remove
    else # exit
      puts 'Error in read_action_add_remove'
    end
  end

  def read_action_remove
    departure_point = Input.read_departure_point
    if @departure_points.remove_train(departure_point, Input.read_train)
      puts 'Your train has been removed from the database'
    else
      puts 'Your train has not been found in the database'
    end
  end

  def read_action_print(action)
    case action
    when /^pt$/ # print (departure point, arrival time)
      dep_point = Input.read_departure_point
      arr_time = Input.read_arrival_time
      @departure_points.print_train_dep_point_arr_time(dep_point, arr_time)
    when /^pp$/ # print (departure point, arrival point)
      dep_point = Input.read_departure_point
      arr_point = Input.read_arrival_point
      @departure_points.print_train_dep_point_arr_point(dep_point, arr_point)
    else # exit
      puts 'Error in read_action_print'
      return
    end
    puts 'All trains according to your request has been printed'
  end
end
