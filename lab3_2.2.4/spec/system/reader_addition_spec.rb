# frozen_string_literal: true

RSpec.describe 'the reader addition', type: :feature do
  it 'should add reader correctly' do
    visit('/')
    click_on('Список читателей')
    click_on('Добавить')
    fill_in('Фамилия', with: 'Петров')
    fill_in('Имя', with: 'Петр')
    fill_in('Отчество', with: 'Петрович')
    fill_in('Возраст', with: '18')
    click_on('Добавить')
    expect(page).to have_content('Петров Петр Петрович 18')
  end

  it 'should show errors' do
    visit('/')
    click_on('Список читателей')
    click_on('Добавить')
    fill_in('Фамилия', with: '')
    fill_in('Имя', with: '')
    fill_in('Отчество', with: '')
    fill_in('Возраст', with: '-18')
    click_on('Добавить')
    expect(page).to have_content("Ошибки ввода данных\n" \
    "Поле с фамилией не может быть пустым, если фамилии нет, введите \"-\".\n" \
    "Поле с именем не может быть пустым.\n" \
    "Поле с отчеством не может быть пустым, если отчества нет, введите \"-\".\n" \
    'Возраст должен быть положительным числом.')
  end

  after do
    File.delete(Constants::PATH_TO_DATABASE_BOOKS) if File.exist?(Constants::PATH_TO_DATABASE_BOOKS)
    File.delete(Constants::PATH_TO_DATABASE_READERS) if File.exist?(Constants::PATH_TO_DATABASE_READERS)
  end
end
