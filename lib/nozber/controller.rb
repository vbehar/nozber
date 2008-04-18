module Nozber
    
  class Controller < SimpleConsole::Controller
    include Nozber::NozbeHelper
    before_filter :ensure_login, :except => [:default, :help, :login, :logout, :method_missing]
    
    params :string => {
      :email => :email, :password => :password,
      :n => :name, :p => :project_name, :c => :context_name
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
      @user = Nozber::Config.new().new_user(params[:email], params[:password]) if params[:email] and params[:password]
    end
    
    def logout
      Nozber::Config.remove_config_file
    end
    
    def params_error
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
      @actions = Nozbe::Action.list(@user.key, true)
    end
    
    def next_actions
      @actions = Nozbe::Action.list_next(@user.key)
      render :action => :list_actions
    end
    
    def list_notes
      @notes = Nozbe::Note.list(@user.key)
    end
    
    def new_project
      redirect_to :action => :params_error unless params[:name] and params[:body]
      @project = create_new_project(@user.key, params[:name], params[:body])
    end
    
    def new_note
      redirect_to :action => :params_error unless params[:name] and params[:body]
      @note = create_new_note(@user.key, params[:name], params[:body], params[:project_name], params[:context_name])
    end
    
    private
    
    def load_user
      @user = Nozber::Config.new().load_user rescue nil
    end
    
    def ensure_login
      load_user
      redirect_to :action => :login if @user.nil? or !@user.logged_in?
    end
    
    def method_missing(symbol)
      Nozber::View.new(self).method_error
    end
    
  end
    
end

