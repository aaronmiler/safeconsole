require "artii"

module Safeconsole
  module Messages
    module_function

    def app_name
      a = Artii::Base.new font: "slant"
      a.asciify(Safeconsole.config.app_name)
    end

    def welcome
      <<~MSG
        #{app_name}

        Current Rails Env: #{Safeconsole.config.current_env}

        Welcome to safeconsole, you're in good hands.

      MSG
    end

    def commands
      <<~MSG
        Usage:
          - refresh: Load a new transaction (and commit if configured)
          - commit: Set this transaction to be commited to the DB on refresh/exit
          - nevermind: Set this transaction to be *discarded* on refresh/exit
          - state: Print the current transaction and session state (commit status, length, stats)
          - commands: Print command instructions again

        Hotkeys:
          - ctrl+d: Load a new transaction (equivilent to refresh)

      MSG
    end

    def unsafe_env
      <<~MSG
        SAFECONSOLE WARNING
          Safeconsole is configured to now allow unsafe consoles for the current environment: #{Safeconsole.env}
          This session will now exit. If this is a mistake, check your safeconsole configuration
      MSG
    end
  end
end
