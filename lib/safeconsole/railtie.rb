require "safeconsole"
require "rails"

module Safeconsole
  class Railtie < Rails::Railtie
    rake_tasks do
      desc "start a Safeconsole session"
      task safeconsole: :environment do
        Safeconsole.start!
      end
    end

    console do
      if !Safeconsole.allow_unsafe? && Safeconsole.config.environments.include?(Rails.env)
        puts Safeconsole::Messages.unsafe_env
        exit
      end
    end
  end
end
