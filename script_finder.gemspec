# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{script_finder}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tobias Crawley"]
  s.date = %q{2009-03-31}
  s.default_executable = %q{s}
  s.email = %q{tcrawley@gmail.com}
  s.executables = ["s"]
  s.extra_rdoc_files = ["README.textile", "LICENSE"]
  s.files = ["README.textile", "VERSION.yml", "bin/s", "lib/script_finder", "lib/script_finder/script_finder.rb", "lib/script_finder.rb", "test/test_helper.rb", "test/test_script_finder.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tobias/script_finder}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A gem that provides tools to find and execute scripts in a project.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
