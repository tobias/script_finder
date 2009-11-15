require 'ftools'

module ScriptFinder
  DEFAULT_BIN_DIR = 'script'
  
  def self.find_and_execute(command, bin_dir = nil)
    command = command.split(' ') if command.is_a?(String)
    finder = Finder.new(command, bin_dir).execute_command
  end

  class Finder
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

    def unique_prefixes(possibles, prefixes = {})
      if prefixes.values.uniq.size < possibles.size
        possibles.each do |cmd|
          prefixes[cmd] ||= ""
          if prefix_is_not_unique?(cmd, prefixes[cmd], possibles)
            prefixes[cmd] += cmd[prefixes[cmd].size,1]
          end
        end
        unique_prefixes(possibles, prefixes)
      else
        prefixes
      end
    end

    protected
    
    def prefix_is_not_unique?(current_cmd, current_prefix, possibles)
      other_possibles = possibles.clone
      other_possibles.delete(current_cmd)

      (current_prefix.empty? or
       other_possibles.inject(false) {|accum, c| accum || c[0,current_prefix.length] == current_prefix}) and
        current_cmd.length > current_prefix.length
    end
    
    def bin_dir_exists_in_pwd?
      File.exists?(bin_dir) and
        File.directory?(bin_dir) and
        File.readable?(bin_dir)
    end
    
    def bin_dir_not_found
      puts "No #{bin_dir} dir found"
    end
    
    def cmd_not_found
      puts "No script found matching '#{command.first}'"
    end

    def too_many_cmds_found(possibles)
      exec_name = File.basename($0)
      puts "'#{exec_name} #{command.first}' was ambiguous. Try:"
      unique_prefixes(possibles).each do |cmd, prefix|
        puts "\t'#{exec_name} #{prefix}' for '#{File.join(bin_dir, cmd)}'"
      end
    end
    
    def commands_to_command_string(commands)
      commands.collect {|x| "'#{x}'"}.join(' ')
    end
  end
end
