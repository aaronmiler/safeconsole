require "pry"
require "singleton"

module Safeconsole
  class Console
    include Singleton
    extend Safeconsole::Commands

    class << self
      attr_accessor :__console_done, :__console_commit

      @__console_done = false
      @__console_commit = false

      def run
        puts Messages.welcome
        puts Messages.commands

        SessionWatcher.watch_session! if Safeconsole.watch_session?

        puts Messages.session_start

        loop do
          @__console_done = false
          @__console_commit = false
          puts Messages.transaction_start

          ActiveRecord::Base.transaction do
            binding.pry quiet: true, prompt_name: "safeconsole"

            raise ActiveRecord::Rollback unless @__console_commit
          end

          if @__console_done
            puts Messages.done
            break
          else
            puts Messages.refresh
            sleep 0.5
          end
        end
      end

      def done!
        @__console_done = true
        @__exit_safeconsole = true
      end

      def closed
        @__exit_safeconsole = false
      end
    end
  end
end
