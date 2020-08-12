# frozen_string_literal: true

require_relative 'book'

# The class with all books in our library
class Library
  attr_reader :books
  def initialize
    @books = {}
  end

  def add_book(number, book)
    @books[number] = book
  end

  def remove_book(number)
    @books.delete(number)
  end

  def remove_copies_book(number, copies)
    copies = copies.to_i
    @books[number].edit_copies_book(@books[number].copies_book - copies)
    @books[number].edit_free_book(@books[number].free_book - copies)
    remove_book(number) if @books[number].copies_book.zero?
  end

  def sort_author
    @books = Hash[@books.sort_by { |_, value| value.author_name }]
  end

  def sort_name
    @books = Hash[@books.sort_by { |_, value| value.name }]
  end

  def choose_book_author_genre(age, search)
    books_result = {}
    @books.each_pair do |number, book|
      if age >= book.min_reader_age && (book.author_name.include?(search) || book.genre.include?(search))
        books_result[number] = book
      end
    end
    books_result
  end
end
