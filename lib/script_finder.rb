$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


require 'abbrev'
require 'ftools'

require File.join(File.dirname(__FILE__), 'utilities', 'script_utilities')


require File.join(File.dirname(__FILE__), 'script_finder', 'finder_base')
require File.join(File.dirname(__FILE__), 'script_finder', 'rails_finder')
require File.join(File.dirname(__FILE__), 'script_finder', 'script_finder')
