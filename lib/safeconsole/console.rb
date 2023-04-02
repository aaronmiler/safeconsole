require "pry"
require "singleton"

module Safeconsole
  class Console
    include Singleton
    include Messages

    extend Commands

    class << self
      attr_accessor :__console_done, :__console_commit

      def run
        print_message(:welcome)
        print_message(:commands)

        SessionWatcher.watch_session! if Safeconsole.watch_session?

        print_message(:session_start)

        loop do
          @__console_done = false
          @__console_commit = false
          print_message(:transaction_start)

          ActiveRecord::Base.transaction do
            binding.pry quiet: true, prompt_name: "safeconsole" # standard:disable Lint/Debugger

            raise ActiveRecord::Rollback unless @__console_commit
          end

          break print_message(:done) if @__console_done

          print_message(:refresh)
          sleep 0.5
        end
      end

      def done!
        @__console_done = true
        @__exit_safeconsole = true
      end

      def done?
        @__console_done
      end
    end
  end
end
