# frozen_string_literal: true

require 'core'

RSpec.describe Core do
  before do
    @core = Core.new
    book1 = Book.new('author_name' => 'Turgenev_I_S', 'name' => 'Asya', 'genre' => 'Novel',
                     'min_reader_age' => '0', 'copies_book' => '20')
    @core.library.add_book('6789', book1)
    person1 = Person.new('Petrov', 'Alexey', 'Olegovich', '23')
    @core.readers.add_person_without_duplication(person1)
    book2 = Book.new('author_name' => 'Kuprin_A_I', 'name' => 'Belyi_pudel', 'genre' => 'Tale',
                     'min_reader_age' => '0', 'copies_book' => '15')
    @core.library.add_book('4567', book2)
    @core.library.books['4567'].edit_free_book(@core.library.books['4567'].free_book - 2)
    person2 = Person.new('Petrov', 'Oleg', 'Olegovich', '23', '4567' => Date.new(2000, 12, 5))
    @core.readers.add_person_without_duplication(person2)
    person3 = Person.new('Ivanov', 'Oleg', 'Olegovich', '23', '4567' => Date.new(2056, 12, 5))
    @core.readers.add_person_without_duplication(person3)
    book3 = Book.new('author_name' => 'Kuprin_A_I', 'name' => 'Granatovyi_braslet', 'genre' => 'Tale',
                     'min_reader_age' => '10', 'copies_book' => '15')
    @core.library.add_book('222', book3)
  end

  # context '#read_db' do
  #   it 'should read data from correct file' do
  #     filename_book = 'non-existent_book.csv'
  #     row1_book = { 'Author_name' => 'QQBulgakov_M_A', 'Name' => 'Master_i_Margarita', 'Genre' => 'Novel',
  #                   'Min_reader_age' => '17', 'Number' => '333', 'Copies_book' => '5' }
  #     row2_book = { 'Author_name' => 'QBulgakov_M_A', 'Name' => 'Master_i_Margarita', 'Genre' => 'Novel',
  #                   'Min_reader_age' => '17', 'Number' => '123', 'Copies_book' => '15' }
  #     expect(CSV).to receive(:foreach).with(filename_book, headers: true).and_return([row1_book, row2_book])
  #     filename_readers = 'non-existent_readers.csv'
  #     row1_person = { 'Last_name' => 'Q', 'First_name' => 'Q', 'Patronymic' => 'Q', 'Age' => '1',
  #                     'Book_number' => '333', 'Date' => '12.12.2012' }
  #     row2_person = { 'Last_name' => 'Q', 'First_name' => 'Q', 'Patronymic' => 'Q', 'Age' => '1',
  #                     'Book_number' => '123', 'Date' => '12.11.2012' }

  #     expect(CSV).to receive(:foreach).with(filename_readers, headers: true).and_return([row1_person, row2_person])
  #     @core.read_db(filename_book, filename_readers)
  #   end
  # end
  context '#take_book' do
    it 'should take' do
      @core.take_book(0, '222', '12.12.2018')
    end
  end

  context '#return_book' do
    it 'should take' do
      @core.take_book(0, '222', '12.12.3018')
      @core.return_book(0, '222')
    end
  end

  context '#read_db and #save' do
    it 'should read data from non-existent file' do
      begin
        filename_book = 'non-existent_book2.csv'
        filename_readers = 'non-existent_readers2.csv'
        @core.read_db(filename_book, filename_readers)
        @core.save(filename_book, filename_readers)
        File.delete(filename_book)
        File.delete(filename_readers)
      end
    end

    it 'should read data from correct file' do
      filename_book = 'non-existent_book2.csv'
      filename_readers = 'non-existent_readers2.csv'
      @core.save(filename_book, filename_readers)
      @core.read_db(filename_book, filename_readers)
      File.delete(filename_book)
      File.delete(filename_readers)
    end
  end
end
