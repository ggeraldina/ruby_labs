# frozen_string_literal: true

RSpec.describe 'the books selection for reader', type: :feature do
  it 'should select book' do
    visit('/')
    click_on('Список читателей')
    click_on('Добавить')
    fill_in('Фамилия', with: 'Сидоров')
    fill_in('Имя', with: 'Николай')
    fill_in('Отчество', with: 'Николаевич')
    fill_in('Возраст', with: '18')
    click_on('Добавить')
    click_on('Список книг')
    click_on('Добавить')
    fill_in('Номер', with: '10000009')
    fill_in('Название', with: 'Мастер и Маргарита')
    fill_in('Автор', with: 'Булгаков М.А.')
    fill_in('Жанр', with: 'Роман')
    fill_in('Количество', with: '3')
    fill_in('Возрастная категория (n+)', with: '16')
    click_on('Добавить')
  end

  after do
    File.delete(Constants::PATH_TO_DATABASE_BOOKS) if File.exist?(Constants::PATH_TO_DATABASE_BOOKS)
    File.delete(Constants::PATH_TO_DATABASE_READERS) if File.exist?(Constants::PATH_TO_DATABASE_READERS)
  end
end
