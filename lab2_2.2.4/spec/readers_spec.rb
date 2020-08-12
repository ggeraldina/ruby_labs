require 'readers'

RSpec.describe Readers do
  context '#add_person' do
    it 'should remove book with number 123' do
      raeders = Readers.new
      person = Person.new('Ivanov', 'Ivan', 'Ivanovich', '24',
                          '456' => '13.10.19')
      raeders.add_person(person)
    end
  end
end
