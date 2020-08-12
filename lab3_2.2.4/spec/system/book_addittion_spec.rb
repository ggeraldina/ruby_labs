# frozen_string_literal: true

RSpec.describe 'the book addition', type: :feature do
  it 'should add the book correctly' do
    visit('/')
    click_on('Добавить')
    fill_in('Номер', with: '10000001')
    fill_in('Название', with: 'Мастер и Маргарита')
    fill_in('Автор', with: 'Булгаков М.А.')
    fill_in('Жанр', with: 'Роман')
    fill_in('Количество', with: '3')
    fill_in('Возрастная категория (n+)', with: '16')
    click_on('Добавить')
    expect(page).to have_content('10000001 Мастер и Маргарита Булгаков М.А. Роман 3 3')
  end

  it 'should show errors' do
    visit('/')
    click_on('Добавить')
    fill_in('Номер', with: '-123456')
    fill_in('Название', with: '')
    fill_in('Автор', with: '')
    fill_in('Жанр', with: '')
    fill_in('Количество', with: '=3')
    fill_in('Возрастная категория (n+)', with: '16+')
    click_on('Добавить')
    expect(page).to have_content("Ошибки ввода данных\n" \
    "Номер должен быть положительным числом, не начинающимся с 0.\n" \
    "Поле с автором не может быть пустым.\n" \
    "Поле с названием не может быть пустым.\n" \
    "Поле с жанром не может быть пустым.\n" \
    "Количество должно быть положительным числом.\n" \
    'Возраст должен быть положительным числом.')
  end

  it 'should show errors about duplicate' do
    visit('/')
    click_on('Добавить')
    fill_in('Номер', with: '10000002')
    fill_in('Название', with: 'Мастер и Маргарита')
    fill_in('Автор', with: 'Булгаков М.А.')
    fill_in('Жанр', with: 'Роман')
    fill_in('Количество', with: '3')
    fill_in('Возрастная категория (n+)', with: '16')
    click_on('Добавить')
    expect(page).to have_content('10000002 Мастер и Маргарита Булгаков М.А. Роман 3 3')
    click_on('Добавить')
    fill_in('Номер', with: '10000002')
    fill_in('Название', with: '2Мастер и Маргарита')
    fill_in('Автор', with: '2Булгаков М.А.')
    fill_in('Жанр', with: '2Роман')
    fill_in('Количество', with: '23')
    fill_in('Возрастная категория (n+)', with: '26')
    click_on('Добавить')
    expect(page).to have_content("Ошибки ввода данных\n" \
                                 'Книга с таким номером уже существует.')
  end

  it 'should add the book correctly' do
    visit('/')
    click_on('Добавить')
    click_on('Отмена')
    expect(page).to have_content("Список книг Список читателей\nСписок книг")
  end

  after do
    File.delete(Constants::PATH_TO_DATABASE_BOOKS) if File.exist?(Constants::PATH_TO_DATABASE_BOOKS)
    File.delete(Constants::PATH_TO_DATABASE_READERS) if File.exist?(Constants::PATH_TO_DATABASE_READERS)
  end
end
