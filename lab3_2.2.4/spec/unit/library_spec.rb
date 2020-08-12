# frozen_string_literal: true

require 'library'

RSpec.describe Library do
  context '#remove_copies_book' do
    it 'should remove copies' do
      book1 = Book.new('author_name' => 'Turgenev_I_S', 'name' => 'Asya', 'genre' => 'Novel',
                       'min_reader_age' => '0', 'copies_book' => '20')
      library = Library.new
      library.add_book('6789', book1)
      library.remove_copies_book('6789', '2')
      expect(library.books['6789'].copies_book).to eq(18)
    end
  end
  context '#choose_book_author_genre' do
    it 'should search' do
      book1 = Book.new('author_name' => 'Turgenev_I_S', 'name' => 'Asya', 'genre' => 'Novel',
                       'min_reader_age' => '10', 'copies_book' => '20')
      library = Library.new
      library.add_book('6789', book1)
      expect(library.choose_book_author_genre(12, 'Turgenev_I_S')).to eq(library.books)
    end
  end
  context '#remove_book' do
    it 'should search' do
      book1 = Book.new('author_name' => 'Turgenev_I_S', 'name' => 'Asya', 'genre' => 'Novel',
                       'min_reader_age' => '10', 'copies_book' => '20')
      library = Library.new
      library.add_book('6789', book1)
      library.remove_book('6789')
      expect(library.books).to eq({})
    end
  end
  context '#sort_author' do
    it 'should search' do
      library = Library.new
      book1 = Book.new('author_name' => 'Turgenev_I_S', 'name' => 'Asya', 'genre' => 'Novel',
                       'min_reader_age' => '10', 'copies_book' => '20')
      library.add_book('6789', book1)
      book2 = Book.new('author_name' => 'Kuprin_A_I', 'name' => 'Belyi_pudel', 'genre' => 'Tale',
                       'min_reader_age' => '0', 'copies_book' => '15')
      library.add_book('4567', book2)
      library.sort_author
      expect(library.books).to eq('4567' => book2, '6789' => book1)
    end
  end
  context '#sort_name' do
    it 'should search' do
      library = Library.new
      book1 = Book.new('author_name' => 'Turgenev_I_S', 'name' => 'Asya', 'genre' => 'Novel',
                       'min_reader_age' => '10', 'copies_book' => '20')
      book2 = Book.new('author_name' => 'Kuprin_A_I', 'name' => 'Belyi_pudel', 'genre' => 'Tale',
                       'min_reader_age' => '0', 'copies_book' => '15')
      library.add_book('4567', book2)
      library.add_book('6789', book1)
      library.sort_name
      expect(library.books).to eq('6789' => book1, '4567' => book2)
    end
  end
end
