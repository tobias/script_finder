module PrefixTools
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
end
