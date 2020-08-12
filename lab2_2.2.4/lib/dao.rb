require 'csv'
require_relative File.dirname(__FILE__) + '/library'
require_relative File.dirname(__FILE__) + '/book'
require_relative File.dirname(__FILE__) + '/readers'
require_relative File.dirname(__FILE__) + '/person'
# Data Access Object (DAO)
# The module responsible for sending requests to the database
# and processing the responses received from it
module DAO
  PATH_INPUT_BOOKS = File.dirname(__FILE__) + '/../res/books.csv'.freeze
  PATH_OUTPUT_BOOKS = File.dirname(__FILE__) + '/../res/books_out.csv'.freeze
  PATH_INPUT_READERS = File.dirname(__FILE__) + '/../res/readers.csv'.freeze
  PATH_OUTPUT_READERS = File.dirname(__FILE__) + '/../res/readers_out.csv'.freeze

  def self.read_csv_data(filename_books = PATH_INPUT_BOOKS, filename_readers = PATH_INPUT_READERS)
    library = read_csv_books(filename_books)
    readers = read_csv_readers(filename_readers)
    { 'data_library' => library, 'data_readers' => readers }
  end

  def self.read_csv_books(filename = PATH_INPUT_BOOKS)
    library = Library.new
    CSV.foreach(filename, headers: true) do |row|
      data = { 'author_name' => row['Author_name'], 'name' => row['Name'],
               'genre' => row['Genre'], 'copies_book' => row['Copies_book'],
               'min_reader_age' => row['Min_reader_age'],
               'max_reader_age' => row['Max_reader_age'] }
      book = Book.new(data)
      library.add_book(row['Number'], book)
    end
    library
  rescue SystemCallError
    STDOUT.print "Loading the database...\nNo such file #{filename}\nSuch file created\n"
    write_csv_books(Library.new, filename)
    read_csv_data(filename)
  end

  def self.read_csv_readers(filename = PATH_INPUT_READERS)
    readers = Readers.new
    CSV.foreach(filename, headers: true) do |row|
      person = Person.new(row['Last_name'], row['First_name'],
                          row['Patronymic'], row['Age'],
                          row['Book_number'] => row['Date_return_book'])
      readers.add_person(person)
    end
    readers
  rescue SystemCallError
    STDOUT.print "Loading the database...\nNo such file #{filename}\nSuch file created\n"
    write_csv_readers(Readers.new, filename)
    read_csv_readers(filename)
  end

  def self.write_csv_data(library, readers, filename_books = PATH_OUTPUT_BOOKS,
                          filename_readers = PATH_OUTPUT_READERS)
    write_csv_books(library, filename_books)
    write_csv_readers(readers, filename_readers)
  end

  def self.write_csv_books(library, filename = PATH_OUTPUT_BOOKS)
    CSV.open(filename, 'w') do |csv|
      csv << %w[Author_name Name Genre Min_reader_age Max_reader_age Number Copies_book]
      library.books.each_pair do |number, book|
        csv << [book.author_name, book.name, book.genre, book.min_reader_age,
                book.max_reader_age, number, book.copies_book]
      end
    end
  end

  def self.write_csv_readers(readers, filename = PATH_OUTPUT_READERS)
    CSV.open(filename, 'w') do |csv|
      csv << %w[Last_name First_name Patronymic Age Book_number Date_return_book]
      readers.people.each do |person|
        if person.books.empty?
          csv << [person.last_name, person.first_name, person.patronymic,
                  person.age, '-', '-']
        else
          person.books.each_pair do |book_number, date_return_book|
            csv << [person.last_name, person.first_name, person.patronymic,
                    person.age, book_number, date_return_book.strftime('%d.%m.%Y')]
          end
        end
      end
    end
  end
end
