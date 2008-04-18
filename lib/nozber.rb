# Add the directory containing this file to the start of the load path if it isn't there already.
$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'nozbe'

require 'nozber/nozbe_helper'
require 'nozber/config'

require 'nozber/cli'
require 'nozber/gui'

module Nozber
end
