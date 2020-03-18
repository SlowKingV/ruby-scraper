require_relative '../lib/file_handler.rb'

# WARNING: Delete any <file_handler_testfile.xml> after each run to avoid biased tests
describe FileHandler do
  it '#list_files Class method returns an array with a list of all the .xml files' do
    expect(FileHandler.list_files.all?(/\.xml$/)).to eql true
  end

  context 'Dir and Filename arguments given' do
    let(:obj) { FileHandler.new 'file_handler_testfile', Dir.open('spec/') }

    it 'Creates an instance of FileHandler' do
      expect(obj).to be_an_instance_of FileHandler
    end

    it 'Creates a file inside the given directory with the given name' do
      expect(File.exist?(obj.file_path)).to eql true
    end

    it '#read method returns the raw data from the file' do
      expect(obj.read).to eql File.read(obj.file_path)
    end

    it '#delete Class method deletes current working file' do
      FileHandler.delete_file(obj.file_path)
      expect(File.exist?(obj.file_path)).not_to eql true
    end
  end

  context 'Only Filename argument given' do
    let(:obj) { FileHandler.new 'file_handler_testfile' }

    it 'Still creates an instance of FileHandler' do
      expect(obj).to be_an_instance_of FileHandler
    end

    it 'Still creates a file inside the default directory with the given name' do
      expect(File.exist?(obj.file_path)).to eql true
    end

    it '#delete Class method still deletes current working file inside deffault directory' do
      FileHandler.delete_file(obj.file_path)
      expect(File.exist?(obj.file_path)).not_to eql true
    end
  end

  context 'No arguments given' do
    it 'Rises an ArgumentError' do
      expect { FileHandler.new }.to raise_error ArgumentError
    end
  end
end
