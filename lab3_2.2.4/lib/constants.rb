module Constants
  PATH_TO_DATA = File.expand_path("#{File.dirname(__FILE__)}/../res")
  PATH_TO_DATABASE_BOOKS = "#{Constants::PATH_TO_DATA}/#{ENV['DB_BOOKS_NAME'] || 'books'}.csv".freeze
  PATH_TO_DATABASE_READERS = "#{Constants::PATH_TO_DATA}/#{ENV['DB_READERS_NAME'] || 'readers'}.csv".freeze
end
