require_relative File.dirname(__FILE__) + '/dao'
require_relative File.dirname(__FILE__) + '/message'
require_relative File.dirname(__FILE__) + '/input'
require_relative File.dirname(__FILE__) + '/action'

# The base class
class Core
  PATH_INPUT_BOOKS = File.dirname(__FILE__) + '/../res/books.csv'.freeze
  PATH_OUTPUT_BOOKS = File.dirname(__FILE__) + '/../res/books_out.csv'.freeze
  PATH_INPUT_READERS = File.dirname(__FILE__) + '/../res/readers.csv'.freeze
  PATH_OUTPUT_READERS = File.dirname(__FILE__) + '/../res/readers_out.csv'.freeze

  attr_reader :library, :readers

  def initialize
    @library = Library.new
    @readers = Readers.new
  end

  def run
    Message.show_hello
    begin
      read_action
    rescue Interrupt
      STDOUT.print "\nPressed ctrl-C\nNote: the result of the program is not saved\n"
      # rescue StandardError => e
      #   STDOUT.print "\nReceived Exception #{e}\n"
    end
    # pp @library
    # pp @readers
  end

  def read_action
    loop do
      Message.show_actions
      action = Input.read_action
      case action
      when /^1$/, /^2$/
        Action.read_action_add_remove(@library, @readers, action)
      when /^3$/, /^4$/
        Action.read_action_print(@library, action)
      when /^5$/, /^6$/, /^7$/
        Action.read_action_choose_take_return(@library, @readers, action)
      else
        break
      end
    end
  end

  def read_db(filename_books = PATH_INPUT_BOOKS, filename_readers = PATH_INPUT_READERS)
    data = DAO.read_csv_data(filename_books, filename_readers)
    initialize_library_and_readers(data)
  end

  def save(filename_books = PATH_OUTPUT_BOOKS, filename_readers = PATH_OUTPUT_READERS)
    DAO.write_csv_data(@library, @readers, filename_books, filename_readers)
  end

  def initialize_library_and_readers(data)
    @library = data['data_library']
    data_readers = data['data_readers']
    @readers = Readers.new
    data_readers.people.each do |person|
      person.books.each_pair do |book_number, date_return_book|
        date = Input.str_to_date(date_return_book)
        initialize_add_person(person, book_number, date)
      end
    end
  end

  def initialize_add_person(person, book_number, date_return_book)
    if book_number == '-'
      person.remove_book('-')
      @readers.add_person_without_duplication(person)
      return
    end
    return if @library.books[book_number].nil?

    return if @library.books[book_number].free_book.zero?

    @library.books[book_number].free_book -= 1 unless @readers.person_book?(person, book_number)
    @readers.take_book(person, book_number, date_return_book)
  end
end
