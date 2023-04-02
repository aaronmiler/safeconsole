require "spec_helper"

RSpec.describe Safeconsole::Commands do
  subject { CommandsTestClass }

  it "makes the commands available to the included class" do
    commands = %i[commands refresh done commit nevermind stats]

    commands.each do |command|
      expect(subject.method(command).is_a?(Method)).to be true
    end
  end

  it "#done delegates done to Console" do
    expect(Safeconsole::Console).to receive(:done!).and_call_original

    subject.done
    expect(Safeconsole::Console.done?).to be true
  end

  it "#refresh sends the refresh message" do
    expect(subject.refresh).to eq "safeconsole#refresh"
  end

  it "#commit marks the transaction for saving" do
    expect(CommandsTestClass).to receive(:print_message)

    expect { CommandsTestClass.commit }.to change { Safeconsole::Console.__console_commit }.to(true)
  end

  it "#nevermind changes the transaction to not be committed" do
    expect(CommandsTestClass).to receive(:print_message)

    Safeconsole::Console.__console_commit = true

    expect { CommandsTestClass.nevermind }.to change { Safeconsole::Console.__console_commit }.to(false)
  end
end

class CommandsTestClass
  extend Safeconsole::Commands
end
