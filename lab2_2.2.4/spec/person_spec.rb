require 'person'

RSpec.describe Person do
  before do
    @person = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                         '123' => '23.09.19', '456' => '13.10.19')
  end

  context '#remove_book' do
    it 'should remove book with number 123' do
      @person.remove_book('123')
      person2 = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                           '456' => '13.10.19')
      expect(@person.books).to eq(person2.books)
    end
  end

  context '#remove_book' do
    it 'should do not remove book with number 126' do
      @person.remove_book('126')
      person2 = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                           '123' => '23.09.19', '456' => '13.10.19')
      expect(@person.books).to eq(person2.books)
    end
  end
end
