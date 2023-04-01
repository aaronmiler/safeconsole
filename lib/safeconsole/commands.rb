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
      puts Messages.commit
    end

    def nevermind
      Console.__console_commit = false
      puts Messages.nevermind
    end

    def state
      puts Messages.session_state
    end
  end
end
