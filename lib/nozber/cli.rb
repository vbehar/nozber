require 'simpleconsole'

require 'nozber/cli/controller'
require 'nozber/cli/view_helper'
require 'nozber/cli/view'

module Nozber
  module CLI
    def self.start
      SimpleConsole::Application.run(ARGV, Nozber::CLI::Controller, Nozber::CLI::View)
    end
  end
end