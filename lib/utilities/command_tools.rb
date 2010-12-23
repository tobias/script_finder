module CommandTools
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
end
