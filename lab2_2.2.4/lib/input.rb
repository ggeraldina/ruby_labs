require_relative File.dirname(__FILE__) + '/check'

# The module for receiving input data
module Input
  def self.read_action
    action = $stdin.gets
    action = '' if action.nil?
    #   STDOUT.print "\nPressed ctrl-D\nNote: the result of the program is not saved\n"
    #   exit 0
    # end
    action.chomp
  end

  def self.read_book
    book = {}
    book['author_name'] = read_name('Enter the name of the author, please')
    book['name'] = read_name('Enter the name of the book, please')
    book['genre'] = read_name('Enter the genre of the book, please')
    reader_age = read_reader_age
    book['min_reader_age'] = reader_age['reader_min_age']
    book['max_reader_age'] = reader_age['reader_max_age']
    book['copies_book'] = read_positive_int('Enter the number of copies of the book, please')
    Book.new(book)
  end

  def self.read_person
    last_name = read_name('Enter the last name of the reader, please')
    first_name = read_name('Enter the  first name of the reader, please')
    patronymic = read_name('Enter the patronymic of the reader, please')
    age = read_positive_int('Enter the age of the reader, please')
    Person.new(last_name, first_name, patronymic, age)
  end

  def self.read_reader_age
    loop do
      reader_min_age = read_positive_int('Enter the minimum age of the reader, please')
      reader_max_age = read_positive_int('Enter the maximum age of the reader, please')
      if reader_min_age <= reader_max_age
        return { 'reader_min_age' => reader_min_age, 'reader_max_age' => reader_max_age }
      end

      puts 'The minimum age cannot be greater than the maximum age'
    end
  end

  def self.read_positive_int(message)
    loop do
      puts message
      number = $stdin.gets
      read_positive_int(message) if number.nil?
      number = number.chomp
      return number if Check.verify_positive_int(number)
    end
  end

  def self.read_name(message)
    loop do
      puts message
      name = $stdin.gets
      read_name(message) if name.nil?
      name = name.chomp
      return name if Check.verify_name(name)
    end
  end

  def self.read_date(message)
    loop do
      puts message
      date = $stdin.gets
      read_date if date.nil?
      date = date.chomp
      if Check.verify_date(date)
        date_format = str_to_date(date)
        return date_format unless date_format.nil?
      end
    end
  end

  def self.str_to_date(date)
    day_mon_year = date.split('.')
    day = day_mon_year[0].to_i
    mon = day_mon_year[1].to_i
    year = day_mon_year[2].to_i
    return Date.new(year, mon, day) if Date.valid_date?(year, mon, day)

    puts 'This date not exist'
  end
end
