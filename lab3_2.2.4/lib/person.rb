# frozen_string_literal: true

# The class Reader
class Person
  attr_reader :last_name, :first_name, :patronymic, :age, :books

  def initialize(last_name, first_name, patronymic, age, books = {})
    @last_name = last_name
    @first_name = first_name
    @patronymic = patronymic
    @age = age.to_i
    # book number: date of return of this book
    @books = books
  end

  def ==(other)
    if (@last_name == other.last_name) &&
       (@first_name == other.first_name) &&
       (@patronymic == other.patronymic) &&
       (@age == other.age)
      true
    else
      false
    end
  end

  def remove_book(book_number)
    books.reject! do |key, _|
      key == book_number
    end
  end

  def add_book(book_number, date_return_book)
    @books[book_number] = date_return_book
  end
end
