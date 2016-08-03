require 'spec_helper'

describe Scan do
  describe 'validations' do
    let(:payload) {{ 'result': 'passed', 'event':  'deploy', 'commit': { } }}

    context 'valid post deploy webhook' do
      it 'passes validation' do
        expect(Scan.new(payload).valid?).to eql(true)
      end
    end

    context 'invalid post deploy webhook' do
      before do
        payload['result'] = 'failed'
      end

      it 'fails validation' do
        expect(Scan.new(payload).valid?).to eql(false)
      end
    end
  end

  describe '#perform' do
    before do
      Scan.new({ 'result': 'passed', 'event':  'deploy', 'commit': { } }).save
    end

    it 'triggers OptimizationWorker after save' do
      expect(OptimizationWorker.jobs.size).to eql(1)
    end
  end
end
