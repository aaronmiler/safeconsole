Safeconsole.configure do |conf|
  conf.app_name = "Test App"
  conf.allow_unsafe = true
  conf.environments = %w[]

  # NOTE: Uncomment out to test timeouts
  # conf.command_timeout = 30.seconds

  # NOTE: Uncomment out to test timeouts
  # conf.session_timeout = 5.minutes
end
