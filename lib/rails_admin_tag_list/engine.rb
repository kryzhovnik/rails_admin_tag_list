module RailsAdminTagList
  class Engine < ::Rails::Engine
    initializer 'rails_admin_rag_list.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper RailsAdminTagList::SuggestionsHelper
      end
    end
  end
end
