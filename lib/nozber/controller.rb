module Nozber
    
  class Controller < SimpleConsole::Controller
    before_filter :load_user, :only => [:default, :help]
    before_filter :ensure_login, :except => [:default, :help, :login, :logout]
    
    params :string => {:n => :name, :email => :email, :password => :password}
  
    def default
      redirect_to :action => :help
    end
    
    def help
    end
    
    def login
      if params[:email] and params[:password]
        @user = Nozber::Config.new().new_user(params[:email], params[:password])
      end
    end
    
    def logout
      Nozber::Config.remove_config_file
    end
  
    def list_projects
      @projects = Nozbe::Project.list(@user.key)
      @projects.each{|p| p.load_info(@user.key) }
    end
  
    def list_contexts
      @contexts = Nozbe::Context.list(@user.key)
      @contexts.each{|c| c.load_info(@user.key) }
    end
    
    def next_actions
      @next_actions = Nozbe::Action.list_next(@user.key)
    end
    
    private
    
    def load_user
      @user = Nozber::Config.new().load_user rescue nil
    end
    
    def ensure_login
      load_user
      redirect_to :action => :login if @user.nil? or !@user.logged_in?
    end
    
  end
    
end

