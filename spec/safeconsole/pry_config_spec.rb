require "spec_helper"

RSpec.describe Safeconsole::PryConfig do
  it "adds the two safeconsole hooks to pry" do
    expect(Pry.hooks).to receive(:add_hook).with(:after_read, "safeconsole__transaction_watcher")
    expect(Pry.hooks).to receive(:add_hook).with(:after_eval, "safeconsole__exit")

    described_class.add_hooks
  end
end
