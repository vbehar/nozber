# Add the directory containing this file to the start of the load path if it isn't there already.
$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'simpleconsole'
require 'nozbe'

%w(nozbe_helper config controller view_helper view).each do |dep|
  require "nozber/#{dep}"
end

module Nozber
  def self.start
    SimpleConsole::Application.run(ARGV, Nozber::Controller, Nozber::View)
  end
end

