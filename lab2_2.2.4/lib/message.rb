# The module for displaying messages
module Message
  def self.show_hello
    puts 'Hello!'
    puts 'This is a program that keeps records of books in the library'
  end

  def self.show_actions
    puts 'What do you want?'
    puts '- Enter "1" to add a book or a reader'
    puts '- Enter "2" to remove a book or a reader'
    puts '- Enter "3" to print books sorted by author'
    puts '- Enter "4" to print books sorted by name'
    puts '- Enter "5" to choose a book in the library'
    puts '- Enter "6" to take the book from the library'
    puts '- Enter "7" to return a book to the library'
    puts '- Enter any other key to save and exit'
    STDOUT.print '> '
  end

  def self.show_actions_add
    puts 'What do you want?'
    puts '- Enter "1" to add a book'
    puts '- Enter "2" to add a reader'
    puts '- Enter any other key to go back'
    STDOUT.print '> '
  end

  def self.show_actions_remove
    puts 'What do you want?'
    puts '- Enter "1" to remove a book'
    puts '- Enter "2" to remove a reader'
    puts '- Enter any other key to go back'
    STDOUT.print '> '
  end

  def self.show_actions_choose
    puts 'What do you want?'
    puts '- Enter "1" to select a book by author'
    puts '- Enter "2" to select a book by genre'
    puts '- Enter any other key to go back'
    STDOUT.print '> '
  end
end
