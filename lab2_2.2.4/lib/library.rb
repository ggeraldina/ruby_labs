require_relative File.dirname(__FILE__) + '/book'

# The class with all books in our library
class Library
  attr_reader :books
  def initialize
    @books = {}
  end

  def add_book(number, book)
    @books[number] = book
  end

  def count_free_book(number)
    return 0 if @books.nil?

    return 0 if @books[number].nil?

    @books[number].free_book
  end

  def remove_book(number)
    return true if @books.nil?

    return true if @books[number].nil?

    if @books[number].copies_book == @books[number].free_book
      @books.delete(number)
      true
    else
      false
    end
  end

  def remove_copies_book(number, copies)
    return true if @books.nil?

    return true if @books[number].nil?

    copies = copies.to_i
    remove_copies_book = 0
    if copies > @books[number].free_book
      @books[number].copies_book -= @books[number].free_book
      @books[number].free_book = 0
      remove_copies_book = @books[number].free_book
    else
      @books[number].copies_book -= copies
      @books[number].free_book -= copies
      remove_copies_book = copies
    end
    remove_book(number) if @books[number].copies_book.zero?
    remove_copies_book
  end

  def print_author
    @books = Hash[@books.sort_by { |_, value| value.author_name }]
    @books.each_pair do |number, book|
      puts book.author_name + ' № ' + number + ' ' + book.name
    end
  end

  def print_name
    @books = Hash[@books.sort_by { |_, value| value.name }]
    @books.each_pair do |number, book|
      puts book.name + ' № ' + number + ' ' + book.author_name
    end
  end

  def choose_book_author(age, author)
    @books.each_pair do |number, book|
      if age >= book.min_reader_age && age <= book.max_reader_age && author == book.author_name
        puts ' № ' + number + ' ' + book.author_name + ' ' + book.name
      end
    end
  end

  def choose_book_genre(age, genre)
    @books.each_pair do |number, book|
      if age >= book.min_reader_age && age <= book.max_reader_age && genre == book.genre
        puts ' № ' + number + ' ' + book.author_name + ' ' + book.name
      end
    end
  end
end
