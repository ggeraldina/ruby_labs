# The module checks the entered words
module Check
  def self.verify_positive_int(number)
    if /^[0-9]*$/ =~ number
      true
    else
      puts 'Incorrect format.'
      puts 'The number must be a positive integer'
      false
    end
  end

  def self.verify_name(name)
    if /^[A-Z0-9]{1}[a-zA-Z0-9_ -]*$/ =~ name
      true
    else
      puts 'Incorrect format.'
      puts '1) The it must start with a capital letter or number.'
      puts '2) The it can contain only:'
      puts '- letters(a-z, A-Z)'
      puts '- numbers (0-9)'
      puts '- hyphens(-)'
      puts '- underscores'
      puts '- spaces'
      false
    end
  end

  def self.verify_date(date)
    if /^(0?[1-9]|[12][0-9]|3[01]).(0[1-9]|1[012]).((19|20)[0-9]{2})*$/ =~ date
      true
    else
      puts 'Incorrect format.'
      puts 'The date format must be dd.mm.yyyy or d.mm.yyyy'
    end
  end
end
