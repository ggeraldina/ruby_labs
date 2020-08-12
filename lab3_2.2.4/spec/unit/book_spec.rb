# frozen_string_literal: true

require 'book'

RSpec.describe Book do
  before do
    @book = Book.new('author_name' => 'Turgenev_I_S', 'name' => 'Asya', 'genre' => 'Novel',
                     'min_reader_age' => '0', 'copies_book' => '20')
  end
  context '#edit_copies_book' do
    it 'should edit count copies' do
      @book.edit_copies_book('8')
      expect(@book.copies_book).to eq('8')
    end
  end
  context '#edit_free_book' do
    it 'should edit count copies' do
      @book.edit_free_book('8')
      expect(@book.free_book).to eq('8')
    end
  end
end
