module ScriptUtilities
  #Prefix and string join utilities
 def unique_prefixes(possibles)
    all_prefixes = possibles.abbrev
    all_prefixes.keys.sort.inject({ }) do |prefixes, abbrev|
      prefixes[all_prefixes[abbrev]] ||= abbrev
      prefixes
    end
  end

  def commands_to_command_string(commands)
    commands.collect {|x| "'#{x}'"}.join(' ')
  end

    #Command utilities
  def bin_dir_not_found
    puts "No #{bin_dir} dir found"
  end

  def cmd_not_found
    puts "No script found matching '#{command.first}'"
  end

  def too_many_cmds_found(possibles)
    exec_name = File.basename($0)
    puts "'#{exec_name} #{command.first}' was ambiguous. Try:"
    unique_prefixes(possibles).each do |cmd, prefix|
      puts "\t'#{exec_name} #{prefix}' for '#{File.join(bin_dir, cmd)}'"
    end
  end

  def too_many_options_found(matching_commands)
    puts "'rails #{command.first}' was ambiguous. Try:"
    matching_commands.each do |cmd, pre|
      puts "\t'r #{pre}' for 'rails #{cmd}'"
    end
  end

  def find_command_in_dir(dir)
    cmd = command.first

    Dir.chdir(dir) do
      if cmd and File.executable?(cmd)
        possibles = [cmd]
      else
        # you cheat here by using glob to find all the matching files then verifying the executable nature of them.
        # nice
        possibles = Dir.glob("#{cmd}*").select {|f| File.executable?(f)}
      end

      if possibles.size == 0
        nil
      elsif possibles.size == 1
        File.expand_path(possibles.first)
      else
        possibles
      end
    end
  end

  #Bin Utilities
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
