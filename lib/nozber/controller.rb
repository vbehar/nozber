module Nozber
    
  class Controller < SimpleConsole::Controller
    params :string => {:n => :name}
    @@user = Nozber::Config.new().user
  
    def default
    end
  
    def list_projects
      @projects = Nozbe::Project.list(@@user.key)
      @projects.each{|p| p.load_info(@@user.key) }
    end
  
    def list_contexts
      @contexts = Nozbe::Context.list(@@user.key)
      @contexts.each{|c| c.load_info(@@user.key) }
    end
    
    def next_actions
      @next_actions = Nozbe::Action.list_next(@@user.key)
    end
    
  end
    
end

