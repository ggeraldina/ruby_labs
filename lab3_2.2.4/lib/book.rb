# frozen_string_literal: true

# The class Book
class Book
  attr_reader :author_name, :name, :genre, :copies_book, :min_reader_age, :free_book

  def initialize(data)
    @author_name = data['author_name']
    @name = data['name']
    @genre = data['genre']
    @copies_book = data['copies_book'].to_i
    @min_reader_age = data['min_reader_age'].to_i
    @free_book = data['copies_book'].to_i
  end

  def edit_free_book(number)
    @free_book = number
  end

  def edit_copies_book(number)
    @copies_book = number
  end
end
