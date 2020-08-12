# frozen_string_literal: true

# helper
module InputChecker
  def input_positive_integer?(string)
    num = string.to_i
    num.to_s == string && num > 0
  end

  def input_empty?(string)
    return true if /^[\s]*$/ =~ string

    false
  end

  def self.verify_date(date)
    if /^(0?[1-9]|[12][0-9]|3[01]).(0[1-9]|1[012]).((19|20)[0-9]{2})*$/ =~ date
      true
    else
      false
    end
  end

  def check_input_date(params)
    @errors = []
    day_mon_year = params['date'].split('.')
    day = day_mon_year[0].to_i
    mon = day_mon_year[1].to_i
    year = day_mon_year[2].to_i
    @errors.append('Дата должна иметь формат dd.mm.yyyy.') unless Date.valid_date?(year, mon, day)
    @errors
  end

  def check_input_book(params, books)
    @errors = []
    @errors.append('Книга с таким номером уже существует.') if books.key?(params['number'])
    unless input_positive_integer?(params['number'])
      @errors.append('Номер должен быть положительным числом, не начинающимся с 0.')
    end
    @errors = @errors.concat(check_input_book_empty_string(params))
    @errors.append('Количество должно быть положительным числом.') unless input_positive_integer?(params['copies_book'])
    @errors.append('Возраст должен быть положительным числом.') unless input_positive_integer?(params['min_reader_age'])
    @errors
  end

  def check_input_book_empty_string(params)
    @errors = []
    @errors.append('Поле с автором не может быть пустым.') if input_empty?(params['author_name'])
    @errors.append('Поле с названием не может быть пустым.') if input_empty?(params['name'])
    @errors.append('Поле с жанром не может быть пустым.') if input_empty?(params['genre'])
    @errors
  end

  def check_input_reader(params)
    @errors = []
    if input_empty?(params['last_name'])
      @errors.append('Поле с фамилией не может быть пустым, если фамилии нет, введите "-".')
    end
    @errors.append('Поле с именем не может быть пустым.') if input_empty?(params['first_name'])
    if input_empty?(params['patronymic'])
      @errors.append('Поле с отчеством не может быть пустым, если отчества нет, введите "-".')
    end
    @errors.append('Возраст должен быть положительным числом.') unless input_positive_integer?(params['age'])
    @errors
  end
end
