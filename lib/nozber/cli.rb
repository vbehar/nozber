require 'simpleconsole'
require 'nozbe'
  
class Controller < SimpleConsole::Controller
  params :string => {:n => :name}
  
  def default
    @message = params[:name]
  end
  
  def list
    user = Nozbe::User.new("nozbe-ruby@gmail.com", "plopplop")
    user.login
    @projects = Nozbe::Project.list(user.key)
  end
  
end

class View < SimpleConsole::View
  def default
    puts @message
  end
  def list
    @projects.each do |project|
      p project
    end
  end
end

module Nozber
  class CLI
    def self.execute
      SimpleConsole::Application.run(ARGV, Controller, View)
    end
  end
end
