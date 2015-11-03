require "spec_helper"

describe Lita::Handlers::Notes, lita_handler: true do
  it { is_expected.to route_command("notes").to(:topics) }
  it { is_expected.to route_command("notes foo").to(:note) }


  context "default configuration" do
    it 'responds with default message' do
      send_command("notes")
      expect(replies.last).to eq("No topics available")
    end
  end

  context "with configuration" do
    before do
      registry.config.handlers.notes.notes = { "Test": "Some note", "Other": "Other note"}
    end

    it 'responds with a list of topics' do
      send_command("notes")
      expect(replies.last).to eq("Available topics: Test, Other")
    end

    it 'responds with error message when a topic is unavailable' do
      send_command("notes foo")
      expect(replies.last).to eq("Sorry, I don't know anything about that: foo")
    end

    it 'responds with the notes when a topic is known' do
      send_command("notes test")
      expect(replies.last).to eq("Some note")
    end

  end
end
