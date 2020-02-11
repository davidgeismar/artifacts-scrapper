require_relative '../../../christies/extractors/lot_extractor.rb'
require 'pry-byebug'

describe Christies::LotExtractor do
  describe "get_data" do
    context "item is available" do
      it "is able to get the extra lot details" do
        # agent = double("agent")
        # allow(agent).to receive_message_chain(:get, :uri, :to_s) { "Im-available.com" }
        # allow(agent).to receive_message_chain(:get, :search, :text, :first){ Hash.new }
        # lot = { artist: 'picasso', type: 'painting' }
        # lot_extractor = described_class.new(agent, lot)
        # expect(lot_extractor).to receive(:extra_lot_details)
      end
    end

    context "item is unavailable" do
      it "is doesnt get the lot extra details" do
        agent = double("agent")
        allow(agent).to receive_message_chain(:get, :uri, :to_s) { "https://www.christies.com/?aspxerrorpath=/lotfinder/lot_details.aspx" }
        lot = { artist: 'picasso', type: 'painting' }
        lot_extractor = described_class.new(agent, lot)
        expect(lot_extractor.data[:extra_details]).to be_nil
      end
    end
  end
end
