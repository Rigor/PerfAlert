require 'spec_helper'

describe SlackNotifier do
  describe '#send' do
    let(:messenger) { SlackNotifier.new(SpecPayloads::SLACK) }

    it 'successfully POSTs to Slack', :vcr do
      response = messenger.send
      expect(response.body).to eql('ok')
      expect(response.code).to eql('200')
    end
  end
end
