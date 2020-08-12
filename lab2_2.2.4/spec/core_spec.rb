require 'core'

RSpec.describe Core do
  before do
    @core = Core.new
    book1 = Book.new('author_name' => 'Turgenev_I_S', 'name' => 'Asya', 'genre' => 'Novel',
                     'min_reader_age' => '0', 'max_reader_age' => '30', 'copies_book' => '20')
    @core.library.add_book('6789', book1)
    person1 = Person.new('Petrov', 'Alexey', 'Olegovich', '23')
    @core.readers.add_person_without_duplication(person1)
    book2 = Book.new('author_name' => 'Kuprin_A_I', 'name' => 'Belyi_pudel', 'genre' => 'Tale',
                     'min_reader_age' => '0', 'max_reader_age' => '15', 'copies_book' => '15')
    @core.library.add_book('4567', book2)
    @core.library.books['4567'].free_book -= 2
    person2 = Person.new('Petrov', 'Oleg', 'Olegovich', '23', '4567' => Date.new(2000, 12, 5))
    @core.readers.add_person_without_duplication(person2)
    person3 = Person.new('Ivanov', 'Oleg', 'Olegovich', '23', '4567' => Date.new(2056, 12, 5))
    @core.readers.add_person_without_duplication(person3)
    book3 = Book.new('author_name' => 'Kuprin_A_I', 'name' => 'Granatovyi_braslet', 'genre' => 'Tale',
                     'min_reader_age' => '10', 'max_reader_age' => '75', 'copies_book' => '15')
    @core.library.add_book('222', book3)
    # pp @core.library
    # pp @core.readers
  end

  after do
    @core.run
  end

  context '#read_action' do
    it 'should exit' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('1')
      expect($stdin).to receive(:gets).and_return(nil)
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('back')
      expect($stdin).to receive(:gets).and_return('5')
      expect($stdin).to receive(:gets).and_return('15')
      expect($stdin).to receive(:gets).and_return('back')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'should add a book' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('1')
      expect($stdin).to receive(:gets).and_return('1')
      expect($stdin).to receive(:gets).and_return('12345')
      expect($stdin).to receive(:gets).and_return('Turgenev_I_S')
      expect($stdin).to receive(:gets).and_return('Mumu')
      expect($stdin).to receive(:gets).and_return('Tale')
      expect($stdin).to receive(:gets).and_return('35')
      expect($stdin).to receive(:gets).and_return('30')
      expect($stdin).to receive(:gets).and_return('15')
      expect($stdin).to receive(:gets).and_return('30')
      expect($stdin).to receive(:gets).and_return('8')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'should add a reader' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('1')
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('petrov')
      expect($stdin).to receive(:gets).and_return('Petrov')
      expect($stdin).to receive(:gets).and_return('Petr')
      expect($stdin).to receive(:gets).and_return('Petrovich')
      expect($stdin).to receive(:gets).and_return('-age30')
      expect($stdin).to receive(:gets).and_return('30')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'should remove a non-existent book' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('1')
      expect($stdin).to receive(:gets).and_return('12345')
      expect($stdin).to receive(:gets).and_return('0')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'should remove one copy of a book from 20 ' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('1')
      expect($stdin).to receive(:gets).and_return('6789')
      expect($stdin).to receive(:gets).and_return('1')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'should remove 15 copis of a book from 15 ' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('1')
      expect($stdin).to receive(:gets).and_return('222')
      expect($stdin).to receive(:gets).and_return('15')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'should remove 15 copis of a book from 15 instead 18' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('1')
      expect($stdin).to receive(:gets).and_return('222')
      expect($stdin).to receive(:gets).and_return('18')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'shoude remove a reader' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('Petrov')
      expect($stdin).to receive(:gets).and_return('Alexey')
      expect($stdin).to receive(:gets).and_return('Olegovich')
      expect($stdin).to receive(:gets).and_return('23')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'shoude do not remove a reader with book' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('Petrov')
      expect($stdin).to receive(:gets).and_return('Oleg')
      expect($stdin).to receive(:gets).and_return('Olegovich')
      expect($stdin).to receive(:gets).and_return('23')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'shoude print books sorted by author' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('3')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'shoude print books sorted by name' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('4')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'shoude choose a book in the library by author' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('5')
      expect($stdin).to receive(:gets).and_return('12')
      expect($stdin).to receive(:gets).and_return('1')
      expect($stdin).to receive(:gets).and_return('Turgenev_I_S')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'shoude choose a book in the library by genre' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('5')
      expect($stdin).to receive(:gets).and_return('12')
      expect($stdin).to receive(:gets).and_return('2')
      expect($stdin).to receive(:gets).and_return('Novel')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'shoude new reader take the book from the library' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('6')
      expect($stdin).to receive(:gets).and_return('0')
      expect($stdin).to receive(:gets).and_return('6')
      expect($stdin).to receive(:gets).and_return('6789')
      expect($stdin).to receive(:gets).and_return('Petrov')
      expect($stdin).to receive(:gets).and_return('Denis')
      expect($stdin).to receive(:gets).and_return('Olegovich')
      expect($stdin).to receive(:gets).and_return('74')
      expect($stdin).to receive(:gets).and_return('11.12.14')
      expect($stdin).to receive(:gets).and_return('30.02.2019')
      expect($stdin).to receive(:gets).and_return('11.12.2014')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'shoude exist reader take the book from the library' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('6')
      expect($stdin).to receive(:gets).and_return('0')
      expect($stdin).to receive(:gets).and_return('6')
      expect($stdin).to receive(:gets).and_return('6789')
      expect($stdin).to receive(:gets).and_return('Petrov')
      expect($stdin).to receive(:gets).and_return('Oleg')
      expect($stdin).to receive(:gets).and_return('Olegovich')
      expect($stdin).to receive(:gets).and_return('23')
      expect($stdin).to receive(:gets).and_return('10.02.2016')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'shoude return a book to the library with a fine' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('7')
      expect($stdin).to receive(:gets).and_return('Petrov')
      expect($stdin).to receive(:gets).and_return('Oleg')
      expect($stdin).to receive(:gets).and_return('Olegovich')
      expect($stdin).to receive(:gets).and_return('23')
      expect($stdin).to receive(:gets).and_return('4567')
      expect($stdin).to receive(:gets).and_return('exit')
    end

    it 'shoude return a book to the library without a fine' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('7')
      expect($stdin).to receive(:gets).and_return('Ivanov')
      expect($stdin).to receive(:gets).and_return('Oleg')
      expect($stdin).to receive(:gets).and_return('Olegovich')
      expect($stdin).to receive(:gets).and_return('23')
      expect($stdin).to receive(:gets).and_return('4567')
      expect($stdin).to receive(:gets).and_return('exit')
    end
  end

  context '#read_db' do
    it 'should read data from correct file' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('exit')
      filename_book = 'non-existent_book.csv'
      row1_book = { 'Author_name' => 'QQBulgakov_M_A', 'Name' => 'Master_i_Margarita', 'Genre' => 'Novel',
                    'Min_reader_age' => '17', 'Max_reader_age' => '200', 'Number' => '333', 'Copies_book' => '5' }
      row2_book = { 'Author_name' => 'QBulgakov_M_A', 'Name' => 'Master_i_Margarita', 'Genre' => 'Novel',
                    'Min_reader_age' => '17', 'Max_reader_age' => '200', 'Number' => '123', 'Copies_book' => '15' }
      expect(CSV).to receive(:foreach).with(filename_book, headers: true).and_return([row1_book, row2_book])
      filename_readers = 'non-existent_readers.csv'
      row1_person = { 'Last_name' => 'Q', 'First_name' => 'Q', 'Patronymic' => 'Q', 'Age' => '1',
                      'Book_number' => '333', 'Date' => '12.12.2012' }
      row2_person = { 'Last_name' => 'Q', 'First_name' => 'Q', 'Patronymic' => 'Q', 'Age' => '1',
                      'Book_number' => '123', 'Date' => '12.11.2012' }

      expect(CSV).to receive(:foreach).with(filename_readers, headers: true).and_return([row1_person, row2_person])
      @core.read_db(filename_book, filename_readers)
    end
  end

  context '#read_db and #save' do
    it 'dao' do
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('exit')
      @core.read_db
      @core.save
    end
  end

  it 'should read data from non-existent file' do
    begin
      allow($stdout).to receive(:puts)
      allow(STDOUT).to receive(:print)
      expect($stdin).to receive(:gets).and_return('exit')
      filename_book = 'non-existent_book2.csv'
      filename_readers = 'non-existent_readers2.csv'
      @core.read_db(filename_book, filename_readers)
      @core.save(filename_book, filename_readers)
      File.delete(filename_book)
      File.delete(filename_readers)
    rescue StandardError
      File.delete(filename_book)
      File.delete(filename_readers)
    end
  end
end
