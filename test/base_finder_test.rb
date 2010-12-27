require 'test_helper'
require 'script_finder/base_finder'

class BaseFinderTest < Test::Unit::TestCase
  def test_correct_creation_of_class
    assert f = BaseFinder.new("g")
    assert_equal f.bin_dir, "script"
    assert_equal f.command, "g"
  end

  def test_creation_with_diffent_bin
    assert f = BaseFinder.new("g","robs_special_base_bin")
    assert_equal f.command, "g"
    assert_equal f.bin_dir, "robs_special_base_bin"
  end

  def test_required_class_method_overide
    assert_raise(NotImplementedError){BaseFinder.find_and_execute("hope")}
  end

  def test_unique_prefixes
    prefixes = BaseFinder.new('blah').send(:unique_prefixes, %w{db dbconsole destroy desmond})
    assert_equal prefixes.values.size, prefixes.values.uniq.size
  end

  def test_unique_prefixes_gives_shortest_prefix
    prefixes = BaseFinder.new('blah').send(:unique_prefixes, %w{db dbconsole destroy desmond funball})
    assert_equal 'db', prefixes['db']
    assert_equal 'dbc', prefixes['dbconsole']
    assert_equal 'dest', prefixes['destroy']
    assert_equal 'desm', prefixes['desmond']
    assert_equal 'f', prefixes['funball']
  end
end
