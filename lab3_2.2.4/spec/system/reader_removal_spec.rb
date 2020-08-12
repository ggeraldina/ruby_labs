# frozen_string_literal: true

RSpec.describe 'the reader remove', type: :feature do
  it 'should remove reader' do
    visit('/')
    click_on('Список читателей')
    click_on('Добавить')
    fill_in('Фамилия', with: 'Николаев')
    fill_in('Имя', with: 'Николай')
    fill_in('Отчество', with: 'Николаевич')
    fill_in('Возраст', with: '18')
    click_on('Добавить')
    expect(page).to have_content('Николаев Николай Николаевич 18')
    click_on(id: 'person_Николаев_Николай_Николаевич_18')
    click_on('Удалить')
    expect(page.has_no_content?('Николаев Николай Николаевич 18')).to eq(true)
  end

  after do
    File.delete(Constants::PATH_TO_DATABASE_BOOKS) if File.exist?(Constants::PATH_TO_DATABASE_BOOKS)
    File.delete(Constants::PATH_TO_DATABASE_READERS) if File.exist?(Constants::PATH_TO_DATABASE_READERS)
  end
end
