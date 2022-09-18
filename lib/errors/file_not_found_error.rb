# frozen_string_literal: true

module Errors
  class FileNotFoundError < StandardError
    def initialize(message: 'File not found')
      super(message)
    end
  end
end
