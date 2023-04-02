module Safeconsole
  class Configuration
    attr_accessor :app_name,
      :allow_unsafe,
      :current_env,
      :environments,
      :command_timeout,
      :session_timeout

    def initialize
      @environments = %w[]
      @app_name = Utils.get_app_name
      @allow_unsafe = true
      @current_env = Rails.env
    end
  end

  class << self
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
      @configuration ||= Configuration.new
    end

    def configure
      yield config
    end
  end
end
