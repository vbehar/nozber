require 'gtk2'

module Nozber
  module GUI
    def self.start
      window = Gtk::Window.new
      window.show
      Gtk.main
    end
  end
end