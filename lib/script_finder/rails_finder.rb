class RailsFinder < FinderBase
    #going to check command arguments vs known list of valid rails tasks
    def execute_command
      #call to prefix check
      #verify one command

      cmd = nil
      if cmd.nil?
        cmd_not_found
      elsif cmd.is_a?(Array)
        too_many_cmds_found(cmd)
      else
        exec cmd_string
      end
      #execute command or return errors
    end

    private
    def known_commands
      @known_commands ||= ["generate",'console','server','new',
                          'application','destroy','benchmarker','profiler','plugin','runner']
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
