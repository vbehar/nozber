module Nozber
  module NozbeHelper
    
    def get_project_from_name(user_key, project_name = nil)
      project = Nozbe::Project.get_from_name(user_key, project_name) unless project_name.nil?
      if project.nil?
        Nozbe::Project.get_default_project(user_key)
      else
        project
      end
    end
    
    def get_context_from_name(user_key, context_name = nil)
      context = Nozbe::Context.get_from_name(user_key, context_name) unless context_name.nil?
      if context.nil?
        Nozbe::Context.get_default_context(user_key)
      else
        context
      end
    end
    
  end
end
