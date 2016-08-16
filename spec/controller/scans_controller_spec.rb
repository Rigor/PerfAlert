require 'spec_helper'

describe ScansController do
  describe 'POST', type: :request do
    let(:payload) {SpecPayloads::BASE}

    context 'without credentials' do
      it 'does not authenticate' do
        post '/', scan: payload
        expect(last_response.status).to eql(401)
      end
    end

    context 'with credentials' do
      it 'creates a new scan' do
        http_login
        post '/', scan: payload
        expect(last_response.status).to eql(201)
      end
    end
  end
end
