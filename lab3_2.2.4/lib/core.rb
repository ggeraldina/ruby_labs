# frozen_string_literal: true

require_relative 'dao'
require_relative 'input'
require_relative 'constants'

# The base class
class Core
  PATH_INPUT_BOOKS = Constants::PATH_TO_DATABASE_BOOKS
  PATH_OUTPUT_BOOKS = File.expand_path('../res/books_out.csv', __dir__)
  PATH_INPUT_READERS = Constants::PATH_TO_DATABASE_READERS
  PATH_OUTPUT_READERS = File.expand_path('../res/readers_out.csv', __dir__)

  attr_reader :library, :readers

  def self.init_from_file
    core = Core.new
    core.read_db
    core
  end

  def initialize
    @library = Library.new
    @readers = Readers.new
  end

  def read_db(filename_books = PATH_INPUT_BOOKS, filename_readers = PATH_INPUT_READERS)
    data = DAO.read_csv_data(filename_books, filename_readers)
    initialize_library_and_readers(data)
  end

  def save(filename_books = PATH_OUTPUT_BOOKS, filename_readers = PATH_OUTPUT_READERS)
    DAO.write_csv_data(@library, @readers, filename_books, filename_readers)
  end

  def return_book(index_person, number_book)
    @library.books[number_book].edit_free_book(@library.books[number_book].free_book + 1)
    @readers.remove_book(index_person, number_book)
  end

  def take_book(index_person, number_book, date)
    date_return_book = Input.str_to_date(date)
    unless readers.people[index_person].books.key?(number_book)
      @library.books[number_book].edit_free_book(@library.books[number_book].free_book - 1)
    end
    @readers.take_book_with_index(index_person, number_book, date_return_book)
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

    unless @readers.person_book?(person, book_number)
      @library.books[book_number].edit_free_book(@library.books[book_number].free_book - 1)
    end
    @readers.take_book(person, book_number, date_return_book)
  end
end
