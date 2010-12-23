require 'test_helper'

class FinderBasetest< Test::Unit::TestCase
  def test_correct_creation_of_class
    assert f = FinderBase.new("g")
    assert_equal f.bin_dir, "script"
    assert_equal f.command, "g"
  end

  def test_creation_with_diffent_bin
    assert f = FinderBase.new("g","robs_special_base_bin")
    assert_equal f.command, "g"
    assert_equal f.bin_dir, "robs_special_base_bin"
  end

  def test_required_class_method_overide
    assert_raise(NotImplementedError){FinderBase.find_and_execute("hope")}
  end

end
