module Nozber
  class Config
    attr_reader :user
    
    def initialize()
      @user = Nozbe::User.new('nozbe.ruby@gmail.com', 'plopplop')
      @user.login if !@user.logged_in?
    end
    
  end
end