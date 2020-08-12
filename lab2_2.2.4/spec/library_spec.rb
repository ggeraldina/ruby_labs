require 'library'

RSpec.describe Library do
  context '#remove_book' do
    it 'should don not remove book' do
      library = Library.new
      book = Book.new('author_name' => 'Kuprin_A_I', 'name' => 'Belyi_pudel', 'genre' => 'Tale',
                      'min_reader_age' => '0', 'max_reader_age' => '15', 'copies_book' => '15')
      library.add_book('4567', book)
      library.books['4567'].free_book -= 2
      expect(library.remove_book('4567')).to eq(false)
    end
  end
end
