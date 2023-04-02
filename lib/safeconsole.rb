# frozen_string_literal: true

require_relative "safeconsole/version"

require "safeconsole/utils"
require "safeconsole/configuration"
require "safeconsole/messages"
require "safeconsole/pry_config"
require "safeconsole/session_watcher"
require "safeconsole/commands"
require "safeconsole/console"

module Safeconsole
  require "safeconsole/railtie" if defined?(Rails)

  module_function

  def start!
    Safeconsole::PryConfig.add_hooks
    Safeconsole::Console.run
  end
end
