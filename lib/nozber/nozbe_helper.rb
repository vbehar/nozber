module Nozber
  module NozbeHelper
    
    def create_new_project(user_key, project_name, project_body)
      project = Nozbe::Project.new
      project.name = project_name
      project.body = project_body
      project.save!(user_key)
    end
    
    def create_new_note(user_key, note_name, note_body, project_name = nil, context_name = nil)
      note = Nozbe::Note.new
      note.name = note_name
      note.body = note_body
      note.project = get_project_from_name(user_key, project_name)
      note.context = get_context_from_name(user_key, context_name)
      note.save!(user_key)
    end
    
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
