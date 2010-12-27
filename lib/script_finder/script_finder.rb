require 'script_finder/base_finder'

class ScriptFinder < BaseFinder
  def execute_command
    dir = find_bin_dir

    if dir
      execute_command_if_singleton(find_command_in_dir(dir))
    else
      bin_dir_not_found
    end
  end

  private
  def too_many_cmds_found(cmd)
    super(cmd) { |c| File.join(bin_dir, c) }
  end

  def cmd_not_found
    puts "No script found matching '#{command.first}'"
  end

end
