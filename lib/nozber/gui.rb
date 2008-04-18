require 'gtk2'

require 'nozber/gui/gtk_helper'
require 'nozber/gui/main_window'

module Nozber
  module GUI
    def self.start
      Nozber::GUI::MainWindow.new
    end
  end
end