require File.dirname(__FILE__) + '/test_helper.rb'

class TestScriptFinder < Test::Unit::TestCase
  
  
  def test_unique_prefixes
    prefixes = ScriptFinder::Finder.send('unique_prefixes', %w{db dbconsole destroy desmond})
    assert_equal prefixes.values.size, prefixes.values.uniq.size
  end
  
  def test_unique_prefixes_gives_shortest_prefix
    prefixes = ScriptFinder::Finder.send('unique_prefixes', %w{db dbconsole destroy desmond funball})
    assert_equal 'db', prefixes['db']
    assert_equal 'dbc', prefixes['dbconsole']
    assert_equal 'dest', prefixes['destroy']
    assert_equal 'desm', prefixes['desmond']
    assert_equal 'f', prefixes['funball']
    
  end
  
  
  def test_truth
    assert true
  end
end
