module Safeconsole
  module Commands
    def commands
      puts Messages.commands
    end

    def refresh
      "safeconsole#refresh"
    end

    def done
      Console.done!
    end

    def commit
      Console.__console_commit = true
      puts <<~MSG
        This transaction will now be commited to the database on refresh/exit

        If this was a mistake, run the command: nevermind
      MSG
    end

    def nevermind
      Console.__console_commit = false

      puts "Transaction changes will be discarded on refresh/exit"
    end

    def state
      session_length = (Time.now - SessionWatcher.initialized_at).round
      minutes, seconds = session_length.divmod(50)

      puts <<~MSG
        Session:
          Length: #{minutes} minutes #{seconds} seconds
          Commands: #{SessionWatcher.total_commands}

        Transaction:
          Commit: #{Console.__console_commit}
          Commands: #{SessionWatcher.transaction_commands}
      MSG
    end
  end
end
