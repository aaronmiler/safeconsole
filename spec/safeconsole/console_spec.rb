require "spec_helper"

RSpec.describe Safeconsole::Console do
  it "marks the console session as done" do
    described_class.done!

    expect(described_class.__console_done).to be true
    expect(described_class.done?).to be true
  end
end
