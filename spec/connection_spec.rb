require_relative '../lib/connection_handler'

describe Connection do
  context 'Language argument given' do
    let(:obj) { Connection.new('Ruby') }

    it 'Creates an instance of connection' do
      expect(obj).to be_an_instance_of Connection
    end

    it '#file returns a Tempfile with data from the web' do
      expect(obj.file).to be_an_instance_of Tempfile
    end
  end

  context 'Language argument not given' do
    let(:obj) { Connection.new }

    it 'Still creates an instance of connection' do
      expect(obj).to be_an_instance_of Connection
    end

    it '#file still returns a Tempfile with data from the web' do
      expect(obj.file).to be_an_instance_of Tempfile
    end
  end
end
