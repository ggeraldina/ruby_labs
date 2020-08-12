# frozen_string_literal: true

# The module for receiving input data
module Input
  def self.str_to_date(date)
    day_mon_year = date.split('.')
    day = day_mon_year[0].to_i
    mon = day_mon_year[1].to_i
    year = day_mon_year[2].to_i
    return Date.new(year, mon, day) if Date.valid_date?(year, mon, day)
  end
end
