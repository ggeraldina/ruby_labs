require_relative File.dirname(__FILE__) + '/input'
# The under core - helper modul for core
module UnderAction
  def self.read_action_add_book(library)
    number = Input.read_positive_int('Enter the number of the book, please')
    book = Input.read_book
    library.add_book(number, book)
  end

  def self.read_action_add_reader(readers)
    person = Input.read_person
    readers.add_person_without_duplication(person)
  end

  def self.read_action_remove_book(library)
    number = Input.read_positive_int('Enter the number of the book, please')
    count_for_remove_book = library.count_free_book(number)
    puts "You can remove #{count_for_remove_book} book(s)"
    copies = Input.read_positive_int('Enter the copies of the book for remove, please')
    library.remove_copies_book(number, copies)
  end

  def self.read_action_remove_reader(readers)
    person = Input.read_person
    puts 'You can not remove this reader. The reader has taken the book(s)' unless readers.remove_person(person)
    readers
  end

  def self.take_book(library, readers)
    book_number = Input.read_positive_int('Enter the number of the book, please')
    return puts 'You can not take this book because it not free' if library.count_free_book(book_number).zero?

    person = Input.read_person
    date_return_book = Input.read_date('Enter the date of return of the book, please')
    library.books[book_number].free_book -= 1 unless readers.person_book?(person, book_number)
    readers.take_book(person, book_number, date_return_book)
    { 'library' => library, 'readers' => readers }
  end

  def self.return_book(library, readers)
    person = Input.read_person
    book_number = Input.read_positive_int('Enter the number of the book, please')
    return puts 'This reader do not take this book' unless readers.person_book?(person, book_number)

    sum_fine = readers.count_fine(person, book_number)
    if sum_fine.zero?
      puts 'The book return to the library'
    else
      puts "You have to pay a fine of #{sum_fine} rubles. The book return to the library"
    end
    library.books[book_number].free_book += 1
    readers.remove_book(person, book_number)
    { 'library' => library, 'readers' => readers }
  end
end
