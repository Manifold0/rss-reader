require 'rspec/autorun'

require_relative '../lib/rss_reader.rb'

describe RssReader do
  let(:reader) { RssReader.new(Example.new.data, 7) }

  it "returns an array" do
    expect(reader.inactive_companies).to be_an(Array)
  end

  it "returns an array containing strings" do

  end
end
