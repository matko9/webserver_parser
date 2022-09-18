# frozen_string_literal: true

require_relative 'webpages'
require_relative 'errors/file_not_found_error'
require_relative 'errors/log_format_error'

class WebserverLogParser
  def initialize file
    @file = file
    @webpages = Webpages.new
  end

  def call
    parse
    print_webpages_with_most_page_views
    print_webpages_with_most_unique_page_views
    @webpages.list
  rescue => e
    puts e
  end

  private

  attr_accessor :webpages

  def parse
    raise Errors::FileNotFoundError unless File.file?(@file)

    @file.each do |line|
      page_view = line.split(' ')
      raise Errors::LogFormatError if page_view.length != 2

      webpages.add_page_view({
        page_path: page_view[0].strip,
        ip: page_view[1].strip
      })
    end
  end

  def print_webpages_with_most_page_views
    puts 'PAGES WITH MOST PAGE VIEWS'
    webpages.sorted_by_page_views.each do |webpage|
      puts "#{webpage.path} - #{webpage.page_view_count} visits"
    end
  end

  def print_webpages_with_most_unique_page_views
    puts 'PAGES WITH MOST UNIQUE PAGE VIEWS'
    webpages.sorted_by_unique_page_views.each do |webpage|
      puts "#{webpage.path} - #{webpage.unique_page_view_count} unique visits"
    end
  end
end
