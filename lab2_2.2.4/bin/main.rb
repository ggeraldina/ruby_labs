require_relative File.dirname(__FILE__) + '/../../lib/core'

# Create a base object
core = Core.new
core.read_db
core.run
core.save
