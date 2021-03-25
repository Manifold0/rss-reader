class Test
  require 'rspec'

  require_relative '../lib/rss_reader.rb'

  describe RssReader do
    it "returns a list of companies" do
      reader = RssReader.new(Example.new.data, 7)

      expect(reader.inactive_companies).to be_an(Array)
    end
  end
end