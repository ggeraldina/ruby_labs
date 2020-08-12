# The module for displaying messages
module Message
  def self.show_hello
    puts 'Hello!'
    puts 'This is a program that simulates an information system'
    puts 'at the railway station.'
  end

  def self.show_actions
    puts 'What do you want?'
    puts '- Enter "a" to add train'
    puts '- Enter "r" to remove train'
    puts '- Enter "p" to plan route'
    puts '- Enter "pt" to print trains'
    puts 'with filter (departure point, arrival time)'
    puts '- Enter "pp" to print trains'
    puts 'with filter (departure point, arrival point)'
    puts '- Enter any other key to save and exit'
    print '> '
  end
end
