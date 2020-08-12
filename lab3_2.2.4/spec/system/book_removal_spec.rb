# frozen_string_literal: true

RSpec.describe 'the book addition', type: :feature do
  it 'should remove part copies book' do
    visit('/')
    click_on('Добавить')
    fill_in('Номер', with: '10000003')
    fill_in('Название', with: 'Мастер и Маргарита')
    fill_in('Автор', with: 'Булгаков М.А.')
    fill_in('Жанр', with: 'Роман')
    fill_in('Количество', with: '3')
    fill_in('Возрастная категория (n+)', with: '16')
    click_on('Добавить')
    click_on(id: 'book_10000003')
    select('2', from: 'Количество удаляемых книг')
    click_on('Удалить')
    expect(page).to have_content('10000003 Мастер и Маргарита Булгаков М.А. Роман 1 1')
  end

  it 'should remove book' do
    visit('/')
    click_on('Добавить')
    fill_in('Номер', with: '10000004')
    fill_in('Название', with: 'Мастер и Маргарита')
    fill_in('Автор', with: 'Булгаков М.А.')
    fill_in('Жанр', with: 'Роман')
    fill_in('Количество', with: '3')
    fill_in('Возрастная категория (n+)', with: '16')
    click_on('Добавить')
    click_on(id: 'book_10000004')
    select('3', from: 'Количество удаляемых книг')
    click_on('Удалить')
    expect(page.has_no_content?('10000004 Мастер и Маргарита Булгаков М.А. Роман')).to eq(true)
  end

  after do
    File.delete(Constants::PATH_TO_DATABASE_BOOKS) if File.exist?(Constants::PATH_TO_DATABASE_BOOKS)
    File.delete(Constants::PATH_TO_DATABASE_READERS) if File.exist?(Constants::PATH_TO_DATABASE_READERS)
  end
end
