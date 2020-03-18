require 'open-uri'
require_relative '../lib/scraper.rb'

describe ScrapHTML do
  context 'Both arguments specified' do
    let(:obj) { ScrapHTML.new(URI.open('https://www.codetriage.com'), 30) }

    it 'Creates an instance of ScrapHTML' do
      expect(obj).to be_an_instance_of ScrapHTML
    end

    it 'Generates and stores a parsed HTML Document' do
      expect(obj.doc).to be_an_instance_of Nokogiri::HTML::Document
    end

    it 'Generates and stores an Array filled with Hashes with the extracted data' do
      expect(obj.dataset.all?(Hash)).to eql true
    end

    it 'Generated Array has only the specified quantity of entries (30)' do
      expect(obj.dataset.size).to eql 30
    end

    it 'Retrieves the Language from the file' do
      expect(obj.tag).not_to be_empty
    end
  end

  context 'Only first argument specified' do
    let(:obj) { ScrapHTML.new(URI.open('https://www.codetriage.com')) }

    it 'Still creates an instance of ScrapHTML' do
      expect(obj).to be_an_instance_of ScrapHTML
    end

    it 'Still generates and stores a parsed HTML Document' do
      expect(obj.doc).to be_an_instance_of Nokogiri::HTML::Document
    end

    it 'Still generates and stores an Array filled with Hashes with the extracted data' do
      expect(obj.dataset.all?(Hash)).to eql true
    end

    it 'Generated Array has the default quantity of entries (50)' do
      expect(obj.dataset.size).to eql 50
    end
  end

  context 'No arguments specified' do
    it 'Should raise an ArgumentError' do
      expect { ScrapHTML.new }.to raise_error ArgumentError
    end
  end
end

describe ScrapXML do
  context 'Passed Argument' do
    let(:obj) { ScrapXML.new(File.open('repo/entry_test.xml', 'r')) }

    it 'Creates an instance of ScrapXML' do
      expect(obj).to be_an_instance_of ScrapXML
    end

    it 'Generates and stores a parsed XML Document' do
      expect(obj.doc).to be_an_instance_of Nokogiri::XML::Document
    end

    it 'Generates and stores an Array filled with Hashes with the extracted data' do
      expect(obj.dataset.all?(Hash)).to eql true
    end

    it 'Retrieves the Language from the file (empty)' do
      expect(obj.tag).to be_empty
    end
  end

  context 'No arguments specified' do
    it 'Raises an ArgumentError' do
      expect { ScrapXML.new }.to raise_error ArgumentError
    end
  end
end
