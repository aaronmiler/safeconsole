require "pry"

module Safeconsole
  class PryConfig
    def self.add_hooks
      Pry.hooks.add_hook(:before_session, "welcome") do |_output, _binding, pry|
        if pry.config.prompt_name != "safeconsole"
          puts Safeconsole::Messages.welcome

          if !Safeconsole.allow_unsafe? && Safeconsole.environments.include?(Rails.env)
            puts "You're on production, and this is not a safeconsole. Goodbye."
            binding.eval("exit")
          else
            puts "BEWARE: You're not in a safeconsole"
            puts "Current Rails Environment: #{Rails.env}"
          end
        end
      end

      Pry.hooks.add_hook(:after_eval, "exit_safeconsole") do |output, binding, _pry|
        if Object.const_defined?(:Safeconsole) && (binding.config.prompt_name == "safeconsole")
          Safeconsole::SessionWatcher.command_ran
          if Safeconsole::Console.instance_values["__exit_safeconsole"]
            binding.eval("exit")
            Safeconsole::Console.closed
          end

          if output == "safeconsole#refresh"
            Safeconsole::SessionWatcher.transaction_commands = 0
            binding.eval("exit")
          end
        end
      end
    end
  end
end
