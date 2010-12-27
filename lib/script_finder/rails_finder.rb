require 'script_finder/base_finder'

class RailsFinder < BaseFinder

  def execute_command
    execute_command_if_singleton(matching_commands)
  end

  private

  def too_many_cmds_found(commands)
    super(commands) { |c| "rails #{c}" }
  end

  def cmd_exec(cmd)
    super("rails #{cmd}")
  end
    
  def matching_commands
    known_commands.select{ |cmd| cmd =~ /^#{command.first}.*/ }
  end

  def cmd_not_found
    puts "No rails command found matching '#{command.first}'"
  end

  def known_commands
    # it may be worthwhile to ask rails for the commands and cache
    # them in a .file, in case the rails command is extended to
    # provide more commands
    @known_commands ||= %w{ generate console server dbconsole new application
                             destroy benchmarker profiler plugin runner }
  end

  #Cheat Sheet for Rails Commands
  # generate    Generate new code (short-cut alias: "g")
  # console     Start the Rails console (short-cut alias: "c")
  # server      Start the Rails server (short-cut alias: "s")
  # dbconsole   Start a console for the database specified in config/database.yml
  #             (short-cut alias: "db")
  # new         Create a new Rails application. "rails new my_app" creates a
  #             new application called MyApp in "./my_app"

  #In addition to those, there are:
  # application  Generate the Rails application code
  # destroy      Undo code generated with "generate"
  # benchmarker  See how fast a piece of code runs
  # profiler     Get profile information from a piece of code
  # plugin       Install a plugin
  # runner       Run a piece of code in the application environment
  #
end
