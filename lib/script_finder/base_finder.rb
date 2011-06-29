require 'abbrev'
begin
  require 'ftools'
rescue LoadError
  #ignore, not needed under ruby 1.9
end

class BaseFinder

  attr_accessor :bin_dir
  attr_reader :command

  DEFAULT_BIN_DIR = 'script'

  def self.find_and_execute(command, bin_dir = nil)
    command = command.split(' ') if command.is_a?(String)
    unless running_command_for_current_rails_version?(command.first)
      puts "You are attempting to run a command for a version of rails you are not currently running. Please verify rails version" 
      exit
    end
    finder = new(command, bin_dir).execute_command
  end

  def self.running_command_for_current_rails_version?(command)
    if command =~ /r/i or command =~ /s/i
      right_version = command =~ /r/i ? Regexp.new(/rails\s3\./i) : Regexp.new(/rails\s2\./i)
      return !right_version.match(`rails -v`).nil?
    end

    #unknown command. Assuming that this is the right call and they know what they are doing
    return true
  end

  def initialize(command, bin_dir = nil)
    @command = command
    self.bin_dir = bin_dir || DEFAULT_BIN_DIR
  end

  def execute_command
    raise NotImplementedError.new("You must implement execute_command for subclasses of BaseFinder!")
  end
  
  protected

  def cmd_not_found
    raise NotImplementedError.new("You must implement cmd_not_found for subclasses of BaseFinder!")
  end

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

  def too_many_cmds_found(possibles)
    exec_name = File.basename($0)
    puts "'#{exec_name} #{command.first}' was ambiguous. Try:"
    unique_prefixes(possibles).each do |cmd, prefix|
      puts "\t'#{exec_name} #{prefix}' for '#{yield(cmd)}'"
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

  def bin_dir_exists_in_pwd?
    File.exists?(bin_dir) and
      File.directory?(bin_dir) and
      File.readable?(bin_dir)
  end

  def cmd_exec(cmd)
    cmd.strip!
    puts "--> calling '#{cmd}'"
    exec cmd
  end
  
  def execute_command_if_singleton(commands)
    commands = commands.respond_to?(:to_a) ? commands.to_a : [commands] 
    if commands.empty?
      cmd_not_found
    elsif commands.size > 1
      too_many_cmds_found(commands)
    else
      command.shift
      cmd_exec "#{commands.first} #{commands_to_command_string(command)}"
    end
  end

end
