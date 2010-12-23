class ScriptFinder < FinderBase
  def execute_command
    dir = find_bin_dir

    if dir
      cmd = find_command_in_dir(dir)
      if cmd.nil?
        cmd_not_found
      elsif cmd.is_a?(Array)
        too_many_cmds_found(cmd)
      else
        command.shift
        cmd_string = "#{cmd} #{commands_to_command_string(command)}".strip

        puts "--> calling '#{cmd_string}'"
        exec cmd_string
      end
    else
      bin_dir_not_found
    end
  end
end
