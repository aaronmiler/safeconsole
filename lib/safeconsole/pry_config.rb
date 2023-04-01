require "pry"

module Safeconsole
  class PryConfig
    def self.add_hooks
      Pry.hooks.add_hook(:after_read, "safeconsole__transaction_watcher") do |output, binding, pry|
        if defined?(ActiveRecord) && binding.last_exception.is_a?(ActiveRecord::StatementInvalid)
          puts Messages.invalid_query
        end
      end

      Pry.hooks.add_hook(:after_eval, "safeconsole__exit") do |output, binding, _pry|
        if Object.const_defined?(:Safeconsole) && (binding.config.prompt_name == "safeconsole")
          SessionWatcher.command_ran
          if Console.instance_values["__exit_safeconsole"]
            binding.eval("exit")
            Console.closed
          end

          if output == "safeconsole#refresh"
            SessionWatcher.transaction_commands = 0
            binding.eval("exit")
          end
        end
      end
    end
  end
end
