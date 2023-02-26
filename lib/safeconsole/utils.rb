module Safeconsole
  module Utils
    module_function

    def get_app_name
      return Dir.pwd.split("/")[-1] unless defined?(Rails)
      return Rails.application.class.parent_name if Rails.version <= "6.0"

      Rails.application.class.module_parent_name
    end
  end
end
