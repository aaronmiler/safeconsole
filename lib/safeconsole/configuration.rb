module Safeconsole
  class Configuration
    attr_accessor :enabled,
      :welcome_message,
      :app_name,
      :environments,
      :current_env,
      :allow_unsafe,
      :command_timeout,
      :session_timeout

    def initialize
      @enabled = true
      @environments = %w[]
      @app_name = Utils.get_app_name
      @allow_unsafe = true
      @current_env = Rails.env
    end
  end

  class << self
    def enabled?
      config.enabled
    end

    def allow_unsafe?
      config.allow_unsafe
    end

    def watch_session?
      config.command_timeout.present? || config.session_timeout.present?
    end

    def env
      config.current_env
    end

    def config
      @configuration ||= Safeconsole::Configuration.new
    end

    def config=(config)
      @configuration = config
    end

    def configure
      yield config
    end
  end
end
