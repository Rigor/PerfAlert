require 'spec_helper'

describe HipChatNotifier do
  describe '#send' do
    let(:messenger) { HipChatNotifier.new(SpecPayloads::HIPCHAT) }

    it 'successfully POSTs to HipChat', :vcr do
      response = messenger.send
      expect(response.body).to be_nil
      expect(response.code).to eql(204)
    end
  end
end
