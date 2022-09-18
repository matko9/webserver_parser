# frozen_string_literal: true

module Errors
  class LogFormatError < StandardError
    def initialize(message: 'Wrong log format')
      super(message)
    end
  end
end
