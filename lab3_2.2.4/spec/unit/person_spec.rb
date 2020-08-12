# frozen_string_literal: true

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

  context '#==(other)' do
    it 'should bee true' do
      person2 = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                           '123' => '23.09.19')
      expect(@person == person2).to eq(true)
    end

    it 'should bee false' do
      person2 = Person.new('Ivanova', 'Ivan', 'Ivanovich', '24',
                           '123' => '23.09.19')
      expect(@person == person2).to eq(false)
    end
  end

  context '#add_book' do
    it 'should add book' do
      @person.add_book('789', Date.today)
      expect(@person.books.key?('789')).to eq(true)
    end
  end
end
