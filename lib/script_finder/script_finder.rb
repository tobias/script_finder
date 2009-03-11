require 'ftools'

module ScriptFinder
  class Finder
    
    def self.find_and_execute(command, bin_dir = nil)
      command = command.split(' ') if command.is_a?(String)
      execute_command(command)
    end

    def self.bin_dir=(dir)
      @@bin_dir = dir
    end

    def self.bin_dir
      @@bin_dir ||= 'script'
    end
      
    protected
    
    def self.find_bin_dir(starting_dir = '.', last_dir = nil)
      starting_dir = File.expand_path(starting_dir)

      Dir.chdir(starting_dir) do
        if starting_dir == last_dir
          nil
        elsif bin_dir_exists?
          File.join(starting_dir, bin_dir)
        else
          find_bin_dir('..', starting_dir)
        end
      end
    end
    
    def self.bin_dir_exists?
      File.exists?(bin_dir) and File.directory?(bin_dir) and File.readable?(bin_dir)
    end
    
    def self.find_command_in_dir(dir, command)
      Dir.chdir(dir) do
        if command and File.executable?(command)
          possibles = [command]
        else
          possibles = Dir.glob("#{command}*").select {|f| File.executable?(f)}
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

    def self.execute_command(command)
      dir = find_bin_dir
      
      if dir
        cmd = find_command_in_dir(dir, command.first)
        if cmd.nil?
          cmd_not_found(command)
        elsif cmd.is_a?(Array)
          too_many_cmds_found(command, cmd)
        else
          command.shift
          cmd_string = "#{cmd} #{command.join(' ')}"
          puts cmd_string
          exec cmd_string
        end
      else
        bin_dir_not_found(command)
      end
    end
    
    def self.cmd_not_found(command)
      puts "No script found matching '#{command.first}'"
    end

    def self.too_many_cmds_found(command, possibles)
      exec_name = File.basename($0)
      puts "'#{exec_name} #{command.first}' was too ambiguous. Try:"
      unique_prefixes(possibles).each do |cmd, prefix|
        puts "\t'#{exec_name} #{prefix}' for '#{File.join(bin_dir, cmd)}'"
      end
    end

    def self.unique_prefixes(commands, prefixes = {})
      if prefixes.values.uniq.size < commands.size
        commands.each do |cmd|
          other_prefixes = prefixes.clone
          other_prefixes[cmd] = nil
          prefixes[cmd] ||= ""
          if (prefixes[cmd].empty? or other_prefixes.values.include?(prefixes[cmd])) and cmd.length > prefixes[cmd].length
            prefixes[cmd] += cmd[prefixes[cmd].size,1]
          end
        end
        unique_prefixes(commands, prefixes)
      else
        prefixes
      end
    end
  end
end
