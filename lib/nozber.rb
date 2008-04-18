# Add the directory containing this file to the start of the load path if it isn't there already.
$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

# nozbe-ruby api from rubygems
require 'nozbe'

require 'nozber/nozbe_helper'
require 'nozber/config'

module Nozber
end
