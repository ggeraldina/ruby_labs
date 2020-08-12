# The module checks the entered words
module Check
  def self.verify_point(point)
    if /^[A-Z]{1}[a-zA-Z0-9_ -]*$/ =~ point
      true
    else
      puts 'Incorrect format.'
      puts '1) The point must start with a capital letter.'
      puts '2) The point can contain only:'
      puts '- letters(a-z, A-Z)'
      puts '- numbers (0-9)'
      puts '- hyphens(-)'
      puts '- underscores'
      puts '- spaces'
      false
    end
  end

  def self.verify_time(time)
    if /^(([0,1][0-9])|(2[0-3])):[0-5][0-9]$/ =~ time
      true
    else
      puts 'Incorrect format.'
      puts 'The time must be in 24-hour format (HH:MM)'
      false
    end
  end

  def self.verify_number(number)
    if /^[0-9a-zA-Z_-]*$/ =~ number
      true
    else
      puts 'Incorrect format.'
      puts 'The number can contain only:'
      puts '- letters(a-z, A-Z)'
      puts '- numbers (0-9)'
      puts '- hyphens(-)'
      puts '- underscores'
      false
    end
  end

  def self.verify_price(price)
    if /^[0-9]+(\.[0-9]{2})?$/ =~ price
      true
    else
      puts 'Incorrect format.'
      puts 'The price must be an integer or decimal number'
      puts 'with 2 digits after the point'
      false
    end
  end
end
