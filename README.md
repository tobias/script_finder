# script_finder

* http://github.com/tobias/script_finder

## Description

script_finder provides a script (called `s`) that searches in and up from the current dir 
for a folder (default: `script/`) containing an executable file uniquely identified by the a 
prefix given as the first argument. It then calls that executable, passing the rest of the 
arguments to the called executable. If the given prefix is ambiguous, the script suggests
unique prefixes.

Examples (in a rails 2.x app):

    ~/rails_app/app/views$ s c
    --> calling '/Users/tobias/rails_app/script/console'
    Loading development environment (Rails 2.1.0)
    >> exit
    ~/rails_app/app/views$ s r 'some ruby'
    's r' was ambiguous. Try:
        's ru' for 'script/runner'
        's re' for 'script/remote'
    ~/rails_app/app/views$ s ru 'some ruby'
    --> calling '/Users/tobias/rails_app/script/runner some ruby'
    ...

The gem is not rails specific - out of the box it will work with any project that has a 
`script/` directory. If you want to make your own version of the `s` script that looks for 
executables in a different dir (I would save this one as `c`):

    #!/usr/bin/env ruby

    require 'script_finder/script_finder'
  
    # looks for executables in a commands/ dir instead of script/.
    ScriptFinder.find_and_execute(ARGV, 'commands')

## Rails 3 Support

This gem also provides a `r` script for rails 3.x support. Example:

    ~/rails_app/app/views$ r c
    --> calling 'rails console'
    Loading development environment (Rails 3.0.3)
    >> exit 
    ~/rails_app/app/views$ r d some_model
    'r d' was ambiguous. Try:
	'r de' for 'rails destroy'
    	'r db' for 'rails dbconsole'
    ~/rails_app/app/views$ r de some_model
    --> calling 'rails destroy some_model'
    ...

## Known Issues

* The rails script ('`r`') currently only supports the builtin rails commands
* The gem may not yet properly handle quoted arguments

Email me at: tcrawley@gmail.com if you find any problems.

## Install

* gem install script_finder

## Contributors

* [Robert R. Meyer](https://github.com/Blue-Dog-Archolite)

## License

Copyright (c) 2009-2010 Tobias Crawley

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
