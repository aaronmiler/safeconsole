require "singleton"

module Safeconsole
  class SessionWatcher
    include Singleton

    @initialized_at = Time.now
    @last_command_at = Time.now
    @total_commands = 0
    @transaction_commands = 0

    class << self

      attr_accessor :initialized_at, :last_command_at, :total_commands, :transaction_commands

      def command_ran
        @total_commands += 1
        @transaction_commands += 1
        @last_command_at = Time.now
      end

      def watch_session!
        Thread.start do
          loop do
            if timeout_reached? || session_limit_reached?
              puts "You pass out from exhaustion. The maze has won."
              break binding.eval("exit")
            end

            sleep 2
          end
        end
      end

      def session_limit_reached?
        return false unless Safeconsole.config.session_timeout

        puts "session timeout reached?"

        @initialized_at < Safeconsole.config.session_timeout.ago
      end

      def timeout_reached?
        return false unless Safeconsole.config.command_timeout

        puts "command timeout reached?"

        last_command_at < Safeconsole.config.command_timeout.ago
      end
    end
  end
end

