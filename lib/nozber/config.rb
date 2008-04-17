module Nozber
  class Config
    CONFIG_FILE_PATH = File.expand_path('~/.nozber_config.yaml')
    
    attr_reader :user
    
    def load_user()
      @user = YAML.load_file CONFIG_FILE_PATH
      check_login
    end
    
    def new_user(email, password)
      @user = Nozbe::User.new(email, password)
      check_login
    end
    
    def check_login()
      unless @user.logged_in?
        @user.login
        File.open(CONFIG_FILE_PATH,'w') do |out| 
          YAML.dump(@user, out)
        end
        File.chmod(0600, CONFIG_FILE_PATH)
      end
      @user
    end
    
    def self.config_file_path
      CONFIG_FILE_PATH
    end
    
    def self.remove_config_file()
      File.delete(CONFIG_FILE_PATH) if File.exist?(CONFIG_FILE_PATH)
    end
    
  end
end