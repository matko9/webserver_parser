# frozen_string_literal: true

require_relative '../lib/webserver_log_parser'

RSpec.describe WebserverLogParser do
  let(:webserver_log_parser_text_param) { WebserverLogParser.new('file') }
  let(:webserver_log) { File.open('webserver.log') }
  let(:webserver_log_parser_wrong_format) {
    WebserverLogParser.new(File.open('webserver_wrong_format.log'))
  }

  context 'initialize class' do
    it 'should raise an ArgumentError error if file is not passed' do
      expect { WebserverLogParser.new }.to raise_error(ArgumentError)
    end

    it 'creates a webserver log parser class' do
      expect(webserver_log_parser_text_param).to be_kind_of(WebserverLogParser)
    end
  end

  context 'call' do
    it 'should print an error message if provided file is not found' do
      expect { webserver_log_parser_text_param.call }.to output(/File not found/).to_stdout
    end

    it 'should print an error message if log format is wrong' do
      expect { webserver_log_parser_wrong_format.call }.to output(/Wrong log format/).to_stdout
    end

    subject(:call) { described_class.new(webserver_log).call }
    it 'should parse logs with correct format' do
      expect(call).to_not be_empty
    end
  end
end
