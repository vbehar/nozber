module Nozber
  module GUI
    
    class MainWindow
      include GtkHelper
      
      def initialize()
        @user = Nozber::Config.new().load_user
        
        actions = Nozbe::Action.list(@user.key)
        
        table = Gtk::Table.new(6, actions.size, true)
        
        actions.size.times do |i|
          action = actions[i]
          button = Gtk::Button.new("#{action.id}")
          button.signal_connect("clicked") do
            puts "[#{i}] ID : #{action.id}, NAME : #{action.name}"
          end
          table.attach_defaults(button, 0, 5, i, i + 1)
        end
        
        # ==========
        
        liststore = Gtk::ListStore.new(String, String, String, TrueClass)

        actions.each do |action|
          iter = liststore.append
          iter[0] = action.id
          iter[1] = action.name
          iter[2] = action.project.name
          iter[3] = action.next
        end

        liststore.each do |model,path,iter|
          printf("Row %s: %s %s %s\n", path.to_str, iter[0], iter[1], iter[2]);
        end
        
        view = Gtk::TreeView.new(liststore)
        view.selection.mode = Gtk::SELECTION_SINGLE
        view.headers_visible = true
        view.headers_clickable = true
        view.rules_hint = true
        
        renderer = Gtk::CellRendererText.new
        renderer.text = "Boooo!"
        col = Gtk::TreeViewColumn.new("ID", renderer, :text => 0)
        view.append_column(col)
        col = Gtk::TreeViewColumn.new("Name", renderer, :text => 1)
        view.append_column(col)
        
        renderer = Gtk::CellRendererText.new
        renderer.background = "orange"
        col = Gtk::TreeViewColumn.new("Project", renderer, :text => 2)
        view.append_column(col)
        
        view.signal_connect("row-activated") do |view, path, column|
          puts "Row #{path.to_str} was clicked!"

          if iter = view.model.get_iter(path)
            puts "Double-clicked row contains name #{iter[0]}!"
          end
        end
        
        # ==========
        
        # Create a menu
        menu = Gtk::Menu.new

        # Add an item with a silly callback
        item = Gtk::MenuItem.new("Do Something")
        item.signal_connect("activate") { puts "Did something!" }
        menu.append(item)

        menu.show_all

        # Popup the menu on right click
        view.signal_connect("button_press_event") do |widget, event|
          if event.kind_of? Gdk::EventButton and event.button == 3
            menu.popup(nil, nil, event.button, event.time)
          end
        end

        # Popup the menu on Shift-F10
        view.signal_connect("popup_menu") { menu.popup(nil, nil, 0, Gdk::Event::CURRENT_TIME) }
        
        # ==========
        
        label = Gtk::Label.new
        label.set_markup(@user.email)
        
        button = Gtk::Button.new("Hello World")
        button.signal_connect("clicked") { |w|
          puts "#{w.label} : Hello World"
        }

        window = Gtk::Window.new
        window.signal_connect("delete_event") {
          puts "delete event occurred"
          #true
          false
        }

        window.signal_connect("destroy") {
          puts "destroy event occurred"
          Gtk.main_quit
        }

        window.border_width = 10
        window.add(view)
        window.show_all

        Gtk.main
      end
    end
    
  end
end