require_relative File.dirname(__FILE__) + '/under_action'
# The module
module Action
  def self.read_action_add_remove(library, readers, action)
    case action
    when /^1$/
      read_action_add(library, readers)
    when /^2$/
      read_action_remove(library, readers)
    end
  end

  def self.read_action_add(library, readers)
    loop do
      Message.show_actions_add
      action2 = Input.read_action
      case action2
      when /^1$/
        return { 'library' => UnderAction.read_action_add_book(library), 'readers' => readers }
      when /^2$/
        return { 'library' => library, 'readers' => UnderAction.read_action_add_reader(readers) }
      else
        break
      end
    end
  end

  def self.read_action_remove(library, readers)
    loop do
      Message.show_actions_remove
      action2 = Input.read_action
      case action2
      when /^1$/
        return { 'library' => UnderAction.read_action_remove_book(library), 'readers' => readers }
      when /^2$/
        return { 'library' => library, 'readers' => UnderAction.read_action_remove_reader(readers) }
      else
        break
      end
    end
  end

  def self.read_action_print(library, action)
    case action
    when /^3$/
      library.print_author
    when /^4$/
      library.print_name
    end
  end

  def self.read_action_choose_take_return(library, readers, action)
    case action
    when /^5$/
      choose_book(library)
      { 'library' => library, 'readers' => readers }
    when /^6$/
      UnderAction.take_book(library, readers)
    when /^7$/
      UnderAction.return_book(library, readers)
    end
  end

  def self.choose_book(library)
    age = Input.read_positive_int('Enter the age of the reader, please').to_i
    loop do
      Message.show_actions_choose
      action2 = Input.read_action
      case action2
      when /^1$/
        author = Input.read_name('Enter the author of the book, please')
        return library.choose_book_author(age, author)
      when /^2$/
        genre = Input.read_name('Enter the genre of the book, please')
        return library.choose_book_genre(age, genre)
      else
        break
      end
    end
  end
end
