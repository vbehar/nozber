module Nozber
    
  class Controller < SimpleConsole::Controller
    before_filter :ensure_login, :except => [:default, :help, :login, :logout]
    
    params :string => {
      :email => :email, :password => :password,
      :n => :name
    }
    params :text => {
      :b => :body
    }
  
    def default
      redirect_to :action => :help
    end
    
    def help
      load_user
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
    
    def list_actions
      @actions = Nozbe::Project.list(@user.key).inject([]) { |all_actions, project|
        all_actions + project.get_actions(@user.key, true)
      }
    end
    
    def next_actions
      @actions = Nozbe::Action.list_next(@user.key)
      render :action => :list_actions
    end
    
    def list_notes
      @notes = Nozbe::Project.list(@user.key).inject([]) { |all_notes, project|
        all_notes + project.get_notes(@user.key)
      }
    end
    
    def new_project
      render :action => :params_error unless params[:name] and params[:body]
      @project = Nozbe::Project.new
      @project.name = params[:name]
      @project.body = params[:body]
      @project.save!(@user.key)
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

