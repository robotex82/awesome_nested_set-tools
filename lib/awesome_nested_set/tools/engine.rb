module AwesomeNestedSet
  module Tools
    class Engine < Rails::Engine
      # Add helpers
      config.to_prepare do
        ApplicationController.helper(AwesomeNestedSet::Tools::Helper)
      end
      
      # Add locales
      paths["config/locales"] << File.dirname(__FILE__) + '/../../../config/locales'
    end
  end  
end    
