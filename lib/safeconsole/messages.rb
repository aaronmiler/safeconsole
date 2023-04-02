require "artii"

module Safeconsole
  module Messages
    def self.included(base)
       base.extend ClassMethods
    end

    module ClassMethods
      def print_message(message_name)
        puts Messages.send(message_name)
      end
    end

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

    def session_state
      session_length = (Time.now - SessionWatcher.initialized_at).round
      minutes, seconds = session_length.divmod(50)

      <<~MSG
        Session:
          Length: #{minutes} minutes #{seconds} seconds
          Commands: #{SessionWatcher.total_commands}

        Transaction:
          Commit: #{Console.__console_commit}
          Commands: #{SessionWatcher.transaction_commands}
      MSG
    end

    def commit
      <<~MSG
        This transaction will now be commited to the database on refresh/exit

        If this was a mistake, run the command: nevermind
      MSG
    end

    def nevermind
      "Transaction changes will be discarded on refresh/exit"
    end

    def session_start
      "You're a wizard, searching for a long lost artifact."
    end

    def transaction_start
      "You begin casting a locating spell"
    end

    def refresh
      "Your magic is running low. You stop casting to drink a potion, restoring your energy."
    end

    def done
      "You've located the lost artifact!"
    end

    def session_expired
      "You've been searching for too long. The artifact is lost forever."
    end

    def invalid_query
      <<~MSG

        Active Record Error!
          Oops! Looks like you executed an invalid SQL query. This breaks the current transaction.

          All ActiveRecord based interactions will be broken now. Grab a new transaction with the command: refresh

      MSG
    end

    def unsafe_env
      <<~MSG
        SAFECONSOLE WARNING
          Safeconsole is configured to not allow unsafe consoles for the current environment: #{Safeconsole.env}
          This session will now exit. If this is a mistake, check your safeconsole configuration
      MSG
    end
  end
end
