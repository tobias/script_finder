$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


require 'abbrev'
require 'ftools'

require File.join(File.dirname(__FILE__), 'utilities', 'command_tools')
require File.join(File.dirname(__FILE__), 'utilities', 'prefix_tools')

require File.join(File.dirname(__FILE__), 'script_finder', 'finder')
require File.join(File.dirname(__FILE__), 'script_finder', 'script_finder')
require File.join(File.dirname(__FILE__), 'script_finder', 'rails_task_finder')
require File.join(File.dirname(__FILE__), 'script_finder', 'rails_finder')

