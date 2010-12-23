class FinderBase 
  DEFAULT_BIN_DIR = 'script'

  include ScriptUtilities

  attr_accessor :bin_dir
  attr_reader :command

  def self.find_and_execute(command,bin_dir = nil)
    command = command.split(' ') if command.is_a?(String)
    finder = self.new(command, bin_dir).execute_command
  end

  def initialize(command, bin_dir = nil)
    @command = command
    self.bin_dir = bin_dir || DEFAULT_BIN_DIR
  end

  def execute_command
    raise NotImplementedError.new("You must impliment execute_command for subclasses of FinderBase!")
  end
end
