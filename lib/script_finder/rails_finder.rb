class RailsFinder < FinderBase
    #going to check command arguments vs known list of valid rails tasks
    def execute_command
      #call to prefix check
      #verify one command

      if matching_commands.nil? || matching_commands.empty?
        cmd_not_found
      elsif matching_commands.is_a?(Array) && matching_commands.size > 1
        too_many_options_found(matching_commands)
      else
        exec matching_commands.first[1]
      end
      #execute command or return errors
    end

    private


  def matching_commands
    regexp = Regexp.new("#{command}.*")
    known_commands.select{ |key, value| !regexp.match(value).nil? }
  end

  def known_commands
    @known_commands ||= unique_prefixes(["generate",'console','server','dbconsole', 'new',
                        'application','destroy','benchmarker','profiler','plugin','runner'])
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
