require 'sinatra'
require_relative 'lib/core'
require_relative 'lib/input_checker'

# show and kill process
# lsof -i :4567
# kill -9 PID

helpers InputChecker

configure do
  set :core, Core.init_from_file
end

get '/' do
  @library = settings.core.library.books
  settings.core.library.sort_author
  @checked_sort_author = true
  erb :books
end

post '/' do
  @library = settings.core.library.books
  if params['sort'] == 'checkedSortAuthor'
    settings.core.library.sort_author
    @checked_sort_author = true
  else
    settings.core.library.sort_name
    @checked_sort_author = false
  end
  erb :books
end

get '/new_book' do
  erb :new_book
end

post '/new_book' do
  @errors = check_input_book(params, settings.core.library.books)
  unless @errors.empty?
    @number = params['number']
    @author_name = params['author_name']
    @name = params['name']
    @genre = params['genre']
    @copies_book = params['copies_book']
    @min_reader_age = params['min_reader_age']
    return erb :new_book
  end
  data = { 'author_name' => params['author_name'], 'name' => params['name'],
           'genre' => params['genre'], 'copies_book' => params['copies_book'],
           'min_reader_age' => params['min_reader_age'] }
  book = Book.new(data)
  settings.core.library.add_book(params['number'], book)
  settings.core.save
  redirect to('/')
end

get '/show_book/:number' do
  book = settings.core.library.books[params['number']]
  @number = params['number']
  @name = book.name
  @author_name = book.author_name
  @genre = book.genre
  @min_reader_age = book.min_reader_age
  @copies_book = book.copies_book
  @free_book = book.free_book
  erb :show_book
end

post '/show_book/:number' do
  settings.core.library.remove_copies_book(params['number'], params['count_remove_book'].to_i)
  settings.core.save
  redirect to('/')
end

get '/readers' do
  @readers = settings.core.readers.people
  erb :readers
end

get '/new_reader' do
  erb :new_reader
end

post '/new_reader' do
  @errors = check_input_reader(params)
  unless @errors.empty?
    @last_name = params['last_name']
    @first_name = params['first_name']
    @patronymic = params['patronymic']
    @age = params['age']
    return erb :new_reader
  end
  person = Person.new(params['last_name'], params['first_name'], params['patronymic'], params['age'])
  settings.core.readers.add_person_without_duplication(person)
  settings.core.save
  redirect to('/readers')
end

get '/show_reader/:index' do
  reader = settings.core.readers.people[params['index'].to_i]
  @index = params['index'].to_i
  @last_name = reader.last_name
  @first_name = reader.first_name
  @patronymic = reader.patronymic
  @age = reader.age
  @books = reader.books
  erb :show_reader
end

post '/show_reader/:index' do
  settings.core.readers.remove_person(params['index'].to_i)
  settings.core.save
  redirect to('/readers')
end

get '/return_book/:number/:index' do
  @index = params['index'].to_i
  reader = settings.core.readers.people[params['index'].to_i]
  @last_name = reader.last_name
  @first_name = reader.first_name
  @patronymic = reader.patronymic
  @age = reader.age
  @books = reader.books
  book = settings.core.library.books[params['number']]
  @number = params['number']
  @name = book.name
  @author_name = book.author_name
  @genre = book.genre
  @min_reader_age = book.min_reader_age
  @copies_book = book.copies_book
  @free_book = book.free_book
  @sum_fine = settings.core.readers.count_fine(params['index'].to_i, params['number'])
  settings.core.save
  erb :return_book
end

post '/return_book/:number/:index' do
  settings.core.return_book(params['index'].to_i, params['number'])
  settings.core.save
  redirect to('/show_reader/' + params['index'])
end

get '/search_book/:index' do
  @library = settings.core.library.books
  @index = params['index'].to_i
  erb :search_book
end

post '/search_book/:index' do
  pp params
  @index = params['index'].to_i
  age = settings.core.readers.people[@index].age
  @search = params['search']
  @library = if input_empty?(@search)
               settings.core.library.books
             else
               settings.core.library.choose_book_author_genre(age, @search)
             end
  erb :search_book
end

get '/take_book/:number/:index' do
  @index = params['index'].to_i
  @number = params['number']
  @reader = settings.core.readers.people[@index]
  @book = settings.core.library.books[@number]
  erb :take_book
end

post '/take_book/:number/:index' do
  @errors = check_input_date(params)
  unless @errors.empty?
    @index = params['index'].to_i
    @number = params['number']
    @reader = settings.core.readers.people[@index]
    @book = settings.core.library.books[@number]
    @date = params['date']
    return erb :take_book
  end
  settings.core.take_book(params['index'].to_i, params['number'], params['date'])
  settings.core.save
  redirect to('/search_book/' + params['index'])
end
