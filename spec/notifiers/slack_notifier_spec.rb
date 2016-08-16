require 'spec_helper'

describe SlackNotifier do
  describe '#send' do
    let(:messenger) { SlackNotifier.new(SpecPayloads::SLACK) }

    it 'successfully POSTs to Slack', vcr: { :match_requests_on => [:method] } do
      response = messenger.send
      expect(response.body).to eql('ok')
      expect(response.code).to eql('200')
    end
  end
end
