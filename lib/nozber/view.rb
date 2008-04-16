module Nozber
    
  class View < SimpleConsole::View
    include ViewHelper
    
    def default
      puts "Welcome to nozber - the command line interface to Nozbe"
      puts "Available commands :"
      puts " - list_projects : list of all your projects"
      puts " - list_contexts : list of all your contexts"
    end
  
    def list_projects
      puts [
        just('Name', 20),
        just('Body', 100)
      ].join(" ")
      @projects.each do |p|
        puts [
          just(p.name, 20),
          just(p.body, 100)
        ].join(" ")
      end
    end
  
    def list_contexts
      puts [
        just('Name', 20),
        just('Body', 100)
      ].join(" ")
      @contexts.each do |c|
        puts [
          just(c.name, 20),
          just(c.body, 100)
        ].join(" ")
      end
    end
    
    def next_actions
      puts [
        ' ',
        ' ',
        just('Name', 50),
        just('Project', 20),
        just('Context', 20)
      ].join(" ")
      @next_actions.each do |c|
        puts [
          c.done ? '!' : ' ',
          c.next ? '*' : ' ',
          just(c.name, 50),
          just(c.project.name, 20),
          just(c.context.name, 20)
        ].join(" ")
      end
    end
    
  end
    
end

