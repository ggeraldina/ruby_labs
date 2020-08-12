# frozen_string_literal: true

require_relative 'person'

# The class with all readers
class Readers
  attr_reader :people
  def initialize
    @people = []
  end

  def take_book(person, book_number, date_return_book)
    index_person = @people.index(person)
    if index_person.nil?
      person.add_book(book_number, date_return_book)
      @people.push(person)
    else
      @people[index_person].add_book(book_number, date_return_book)
    end
  end

  def take_book_with_index(index_person, book_number, date_return_book)
    @people[index_person].add_book(book_number, date_return_book)
  end

  # for DAO.read_csv_books
  def add_person(person)
    @people.push(person)
  end

  def add_person_without_duplication(person)
    index_person = @people.index(person)
    @people.push(person) if index_person.nil?
  end

  # for CORE.initialize_add_person and CORE.take_book
  def person_book?(person, book_number)
    index_person = @people.index(person)
    return false if index_person.nil?

    @people[index_person].books.key?(book_number)
  end

  def remove_book(index_person, number_book)
    @people[index_person].remove_book(number_book)
  end

  def remove_person(index_person)
    @people.delete_at(index_person)
  end

  def count_fine(index_person, book_number)
    date_today = Date.today
    date_return = @people[index_person].books[book_number]
    return (date_today - date_return).to_i if date_return < date_today

    0
  end
end
