# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{script_finder}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tobias Crawley"]
  s.date = %q{2009-03-11}
  s.default_executable = %q{s}
  s.description = %q{script_finder provides a script (called 's') that searches in and up from the current dir  for a folder (default: script/) containing an executable file uniquely identified by the a  prefix given as the first argument. It then calls that executable, passing the rest of the  arguments to the called executable. If the given prefix is ambiguous, the script suggests unique prefixes.  Examples (in a rails app):  ~/rails_app/app/views$ s c --> calling '/Users/tobias/rails_app/script/console' Loading development environment (Rails 2.1.0) RowsLogger plugin enables mysql >> exit ~/rails_app/app/views$ s r 'some ruby' 's r' was too ambiguous. Try: 's ru' for 'script/runner' 's re' for 'script/remote' ~/rails_app/app/views$ s ru 'some ruby' --> calling '/Users/tobias/rails_app/script/runner some ruby' ...  The gem is not rails specific - out of the box it will work with any project that has a  'script/' directory. If you want to make your own version of the 's' script that looks for  executables in a different dir (I would save this one as 'c'):  #!/usr/bin/env ruby  require 'script_finder'  # looks for executables in a commands/ dir instead of script/. ScriptFinder.find_and_execute(ARGV, 'commands')}
  s.email = ["tcrawley@gmail.com"]
  s.executables = ["s"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/script_finder.rb", "lib/script_finder/script_finder.rb", "bin/s", "test/test_helper.rb", "test/test_script_finder.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tobias/script_finder}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{script_finder}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{script_finder provides a script (called 's') that searches in and up from the current dir  for a folder (default: script/) containing an executable file uniquely identified by the a  prefix given as the first argument}
  s.test_files = ["test/test_helper.rb", "test/test_script_finder.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
