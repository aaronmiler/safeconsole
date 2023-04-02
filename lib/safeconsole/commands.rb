module Safeconsole
  module Commands
    def commands
      print_message(:commands)
    end

    def refresh
      "safeconsole#refresh"
    end

    def done
      Console.done!
    end

    def commit
      Console.__console_commit = true
      print_message(:commit)
    end

    def nevermind
      Console.__console_commit = false
      print_message(:nevermind)
    end

    def stats
      print_message(:session_stats)
    end
  end
end
