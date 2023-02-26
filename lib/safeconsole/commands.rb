module Safeconsole
  module Commands

    def commands
      puts Safeconsole::Messages.commands
    end

    def refresh
      "safeconsole#refresh"
    end

    def done
      Safeconsole::Console.done!
    end

    def commit
      Safeconsole::Console.__console_commit = true
      puts <<~MSG
        This transaction will now be commited to the database on refresh/exit

        If this was a mistake, run the command: nevermind
      MSG
    end

    def nevermind
      Safeconsole::Console.__console_commit = false

      puts "Transaction changes will be discarded on refresh/exit"
    end

    def state
      session_length = (Time.now - Safeconsole::SessionWatcher.initialized_at).round
      minutes, seconds = session_length.divmod(50)

      puts <<~MSG
        Session:
          Length: #{minutes} minutes #{seconds} seconds
          Commands: #{Safeconsole::SessionWatcher.total_commands}

        Transaction:
          Commit: #{Safeconsole::Console.__console_commit}
          Commands: #{Safeconsole::SessionWatcher.transaction_commands}
      MSG
    end
  end
end
