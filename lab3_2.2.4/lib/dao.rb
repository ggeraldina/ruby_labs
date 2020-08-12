# frozen_string_literal: true

require 'csv'
require_relative 'library'
require_relative 'book'
require_relative 'readers'
require_relative 'person'
# Data Access Object (DAO)
# The module responsible for sending requests to the database
# and processing the responses received from it
module DAO
  def self.read_csv_data(filename_books, filename_readers)
    library = read_csv_books(filename_books)
    readers = read_csv_readers(filename_readers)
    { 'data_library' => library, 'data_readers' => readers }
  end

  def self.read_csv_books(filename)
    library = Library.new
    return library if !File.file?(filename)

    CSV.foreach(filename, headers: true) do |row|
      data = { 'author_name' => row['Author_name'], 'name' => row['Name'],
               'genre' => row['Genre'], 'copies_book' => row['Copies_book'],
               'min_reader_age' => row['Min_reader_age'] }
      book = Book.new(data)
      library.add_book(row['Number'], book)
    end
    library
  end

  def self.read_csv_readers(filename)
    readers = Readers.new
    return readers if !File.file?(filename)

    CSV.foreach(filename, headers: true) do |row|
      person = Person.new(row['Last_name'], row['First_name'],
                          row['Patronymic'], row['Age'],
                          row['Book_number'] => row['Date_return_book'])
      readers.add_person(person)
    end
    readers
  end

  def self.write_csv_data(library, readers, filename_books, filename_readers)
    write_csv_books(library, filename_books)
    write_csv_readers(readers, filename_readers)
  end

  def self.write_csv_books(library, filename)
    CSV.open(filename, 'w') do |csv|
      csv << %w[Author_name Name Genre Min_reader_age Number Copies_book]
      library.books.each_pair do |number, book|
        csv << [book.author_name, book.name, book.genre, book.min_reader_age,
                number, book.copies_book]
      end
    end
  end

  def self.write_csv_readers(readers, filename)
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
