module Nozber
    
  class View < SimpleConsole::View
    include ViewHelper
    
    def help
      puts "Welcome to nozber - the command line interface to Nozbe"
      puts "Available commands :"
      puts [
        ' -',
        just('help', 50),
        just('show this message', 60)
      ].join(" ")
      puts [
        ' -',
        just('login --email YOUR_EMAIL --password YOUR_PASSWORD', 50),
        just('log into your NOZBE account and store login data on disk', 60)
      ].join(" ")
      puts [
        ' -',
        just('logout', 50),
        just('remove all stored login-related data from disk', 60)
      ].join(" ")
      puts [
        ' -',
        just('list_projects', 50),
        just('list all your projects', 60)
      ].join(" ")
      puts [
        ' -',
        just('list_contexts', 50),
        just('list all your contexts', 60)
      ].join(" ")
      puts [
        ' -',
        just('list_actions', 50),
        just('list all your actions', 60)
      ].join(" ")
      puts [
        ' -',
        just('next_actions', 50),
        just('list all your next actions', 60)
      ].join(" ")
      puts [
        ' -',
        just('list_notes', 50),
        just('list all your notes', 60)
      ].join(" ")
      puts [
        ' -',
        just('new_project -n "PROJECT_NAME" -b "PROJECT_BODY"', 50),
        just('create a new project with given name and body', 60)
      ].join(" ")
      puts ""
      if @user
        if @user.logged_in?
          puts "You are logged in with the following email : #{@user.email}"
        else
          puts "It seems that you tried to login but the login fails. Use the 'login' command to fix that."
        end 
      else
        puts "Your are not logged in. Please use the 'login' command."
      end
      puts "The login information are stored in the file : #{Nozber::Config.config_file_path}"
    end
    
    def login
      if @user
        if @user.logged_in?
          puts "OK, login successfull !"
        else
          puts "Oups, unable to login with the email/password you provided."
          puts "Please use the command : 'nozber login --email YOUR_EMAIL --password YOUR_PASSWORD'"
        end
      else
        puts "You need to login first."
        puts "command : 'nozber login --email YOUR_EMAIL --password YOUR_PASSWORD'"
      end
    end
    
    def logout
      puts "Successfully logged out..."
    end
    
    def params_error
      puts "It seems that you made an error with the params..."
      puts "Run the 'nozber help' command to see the synthax"
    end
  
    def list_projects
      puts "#{@projects.size} projects :"
      puts [
        just('Name', 20),
        just('Body', 80)
      ].join(" ")
      @projects.each do |p|
        puts [
          just(p.name, 20),
          just(p.body, 80)
        ].join(" ")
      end
    end
  
    def list_contexts
      puts "#{@contexts.size} contexts :"
      puts [
        just('Name', 20),
        just('Body', 80)
      ].join(" ")
      @contexts.each do |c|
        puts [
          just(c.name, 20),
          just(c.body, 80)
        ].join(" ")
      end
    end
    
    def list_actions
      puts "#{@actions.size} actions :"
      puts [
        ' ',
        ' ',
        just('Name', 60),
        just('Time', 5),
        just('Project', 20),
        just('Context', 20)
      ].join(" ")
      @actions.each do |a|
        puts [
          a.done ? '!' : ' ',
          a.next ? '*' : ' ',
          just(a.name, 60),
          just(a.time, 5),
          just(a.project.name, 20),
          just(a.context.name, 20)
        ].join(" ")
      end
      puts ""
      puts "Legend: ! done, * next"
    end
    
    def list_notes
      puts "#{@notes.size} notes :"
      puts [
        just('Name', 60),
        just('Date', 10),
        just('Project', 20),
        just('Context', 20)
      ].join(" ")
      @notes.each do |n|
        puts [
          just(n.name, 60),
          just(n.date, 10),
          just(n.project.name, 20),
          just(n.context.name, 20)
        ].join(" ")
      end
    end
    
    def new_project
      if @project.id
        puts "Project '#{@project.name}' successfully created (with ID #{@project.id})"
      else
        puts "Unable to save your new project"
      end
    end
    
  end
    
end
