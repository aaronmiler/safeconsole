require "spec_helper"

RSpec.describe Safeconsole::Messages do
  it "makes the #print_message method available when included" do
    expect(MessagesTestClass.method(:print_message).is_a?(Method)).to be true
    expect(MessagesTestModule.method(:print_message).is_a?(Method)).to be true
  end

  it "delegates the given key to messages" do
    expect(Safeconsole::Messages).to receive(:welcome)

    MessagesTestClass.print_message(:welcome)
  end

  it "handles missing keys elegantly" do
    expect(Safeconsole::Messages).to receive(:method_missing)

    MessagesTestClass.print_message(:potato)
  end
end

class MessagesTestClass
  include Safeconsole::Messages
end

module MessagesTestModule
  include Safeconsole::Messages
end
