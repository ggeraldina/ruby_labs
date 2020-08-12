# The class Reader
class Person
  attr_reader :last_name, :first_name, :patronymic, :age, :books
  attr_writer :books
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

  # for Core.initialize_add_person
  def remove_book(book_number)
    books.reject! do |key, _|
      key == book_number
    end
  end
end
