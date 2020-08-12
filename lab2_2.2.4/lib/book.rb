# The class Book
class Book
  attr_reader :author_name, :name, :genre, :copies_book
  attr_reader :min_reader_age, :max_reader_age, :free_book
  attr_writer :free_book, :copies_book
  def initialize(data)
    @author_name = data['author_name']
    @name = data['name']
    @genre = data['genre']
    @copies_book = data['copies_book'].to_i
    @min_reader_age = data['min_reader_age'].to_i
    @max_reader_age = data['max_reader_age'].to_i
    @free_book = data['copies_book'].to_i
  end
end
