require 'find'

require File.join(File.dirname(__FILE__), 'immutable-attribute-plugin', 'init')

# require everything in lib/
Find.find(File.join(File.dirname(__FILE__), 'bookkeeper')) do |file|
  require file if !File.directory?(file) && File.extname(file) == '.rb'
end