module RailsTaskFinder
  def self.find_and_execute(command)
    command = command.split(' ') if command.is_a?(String)
    finder = RailsFinder.new(command).execute_command
  end
end
