# frozen_string_literal: true

require 'readers'
require 'person'

RSpec.describe Readers do
  context '#add_person' do
    it 'should add person' do
      readers = Readers.new
      person = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                          '456' => '13.10.19')
      readers.add_person(person)
    end
  end
  context '#take_book' do
    it 'should take book' do
      readers = Readers.new
      person = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                          '456' => '13.10.19')
      readers.add_person(person)
      readers.take_book(person, '12345', '12.12.2018')
    end
    it 'should take book if not exit person' do
      readers = Readers.new
      person = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                          '456' => '13.10.19')
      readers.take_book(person, '12345', '12.12.2018')
    end
  end
  context '#take_book_with_index' do
    it 'should take book' do
      readers = Readers.new
      person = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                          '456' => '13.10.19')
      readers.add_person(person)
      readers.take_book_with_index(0, '456', '12.12.2018')
      # expect(readers.people[0]).to receive(:add_book).with('456', '12.12.2018')
    end
  end
  context '#person_book?' do
    it 'should person book' do
      readers = Readers.new
      person = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                          '456' => '13.10.19')
      readers.add_person(person)
      expect(readers.person_book?(person, '456')).to eq(true)
    end
  end
  context '#remove_book' do
    it 'should remove book' do
      readers = Readers.new
      person = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                          '456' => '13.10.19')
      readers.add_person(person)
      readers.remove_book(0, '456')
    end
  end
  context '#remove_person' do
    it 'should remove person' do
      readers = Readers.new
      person = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                          '456' => '13.10.19')
      readers.add_person(person)
      readers.remove_person(0)
      expect(readers.people).to eq([])
    end
  end
  context '#count_fine' do
    it 'should count fine' do
      readers = Readers.new
      date = Date.today
      person = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                          '456' => date)
      readers.add_person(person)
      expect(readers.count_fine(0, '456')).to eq(0)
    end
  end
end
