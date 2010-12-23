module ScriptFinder
  DEFAULT_BIN_DIR = 'script'
  
  def self.find_and_execute(command, bin_dir = nil)
    command = command.split(' ') if command.is_a?(String)
    finder = Finder.new(command, bin_dir).execute_command
  end
end
