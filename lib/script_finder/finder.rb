class Finder
  include PrefixTools
  include CommandTools

  attr_accessor :bin_dir
  attr_reader :command
  
  def initialize(command, bin_dir = nil)
    @command = command
    self.bin_dir = bin_dir || DEFAULT_BIN_DIR
  end

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
  
  def find_command_in_dir(dir)
    cmd = command.first
    Dir.chdir(dir) do
      if cmd and File.executable?(cmd)
        possibles = [cmd]
      else
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

  protected
  def bin_dir_exists_in_pwd?
    File.exists?(bin_dir) and
      File.directory?(bin_dir) and
      File.readable?(bin_dir)
  end
end
