require "pry"
require "singleton"

module Safeconsole
  class Console
    include Singleton
    extend Safeconsole::Commands

    Thread.abort_on_exception = true

    class << self
      attr_accessor :__console_done, :__console_commit

      @__console_done = false
      @__console_commit = false

      def run
        puts Safeconsole::Messages.welcome
        puts Safeconsole::Messages.commands

        SessionWatcher.watch_session! if Safeconsole.watch_session?

        loop do
          @__console_done = false
          @__console_commit = false
          puts "You arrive at a series of turns."

          ActiveRecord::Base.transaction do
            binding.pry quiet: true, prompt_name: "safeconsole"

            raise ActiveRecord::Rollback unless @__console_commit
          end

          puts "** You turn a corner and step forward into the darkness **"
          sleep 0.5

          if @__console_done
            puts "You have exited the maze"
            break
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
