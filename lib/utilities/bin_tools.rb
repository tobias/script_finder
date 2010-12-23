module BinTools
  def find_bin_dir(starting_dir = '.', last_dir = nil)
    starting_dir = File.expand_path(starting_dir)

    Dir.chdir(starting_dir) do
      if starting_dir == last_dir
        nil
      elsif bin_dir_exists_in_pwd?
        File.join(starting_dir, bin_dir)
      else
        find_bin_dir('..', starting_dir)
      end
    end
  end

  protected
  def bin_dir_exists_in_pwd?
    File.exists?(bin_dir) and
      File.directory?(bin_dir) and
      File.readable?(bin_dir)
  end
end
