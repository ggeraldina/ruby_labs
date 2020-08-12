# frozen_string_literal: true

require 'constants'

RSpec.describe 'the book taking for reader', type: :feature do
  # before do
  #   File.open(Constants::PATH_TO_DATABASE_BOOKS, 'w+') do |file|
  #     file.write("Author_name,Name,Genre,Min_reader_age,Max_reader_age,Number,Copies_book\n" \
  #                'Bulgakov_M_A,Master_i_Margarita,Novel,17,12398,5')
  #   end
  #   File.open(Constants::PATH_TO_DATABASE_READERS, 'w+') do |file|
  #     file.write("Last_name,First_name,Patronymic,Age,Book_number,Date_return_book\n" \
  #                'Ivanov,Ivan,Ivanych,18,-,-')
  #   end
  # end

  after do
    File.delete(Constants::PATH_TO_DATABASE_BOOKS) if File.exist?(Constants::PATH_TO_DATABASE_BOOKS)
    File.delete(Constants::PATH_TO_DATABASE_READERS) if File.exist?(Constants::PATH_TO_DATABASE_READERS)
  end
end
