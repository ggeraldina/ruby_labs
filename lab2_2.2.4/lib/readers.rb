require_relative File.dirname(__FILE__) + '/person'

# The class with all readers
class Readers
  attr_reader :people
  def initialize
    @people = []
  end

  def take_book(person, book_number, date_return_book)
    index_person = @people.index(person)
    if index_person.nil?
      person.books[book_number] = date_return_book
      @people.push(person)
    else
      @people[index_person].books[book_number] = date_return_book
    end
  end

  # for DAO.read_csv_books
  def add_person(person)
    @people.push(person)
  end

  def add_person_without_duplication(person)
    index_person = @people.index(person)
    @people.push(person) if index_person.nil?
  end

  def person_book?(person, book_number)
    index_person = @people.index(person)
    return false if index_person.nil?

    @people[index_person].books.key?(book_number)
  end

  def remove_book(person, book_number)
    index_person = @people.index(person)
    return if index_person.nil?

    @people[index_person].books.reject! do |key, _|
      key == book_number
    end
  end

  def remove_person(person)
    index_person = @people.index(person)
    return true if index_person.nil?

    return true if @people[index_person].books.empty?

    false
  end

  def count_fine(person, book_number)
    date_today = Date.today
    index_person = @people.index(person)
    date_return = @people[index_person].books[book_number]
    return (date_today - date_return).to_i if date_return < date_today

    0
  end
end
