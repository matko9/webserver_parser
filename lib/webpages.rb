# frozen_string_literal: true

require_relative 'webpage'

class Webpages
  def initialize
    @webpages = []
  end

  def add_page_view data
    webpage = find_webpage(data[:page_path]) || add_new_webpage(data[:page_path])
    webpage.add_page_view(data[:ip])
  end

  def sorted_by_page_views
    @webpages.sort_by { |webpage| -webpage.page_view_count }
  end

  def sorted_by_unique_page_views
    @webpages.sort_by { |webpage| -webpage.unique_page_view_count }
  end

  def list
    @webpages
  end

  private

  attr_accessor :webpages

  def find_webpage page_path
    webpages.find { |webpage| webpage.path == page_path }
  end

  def add_new_webpage page_path
    webpage = Webpage.new(page_path)
    webpages.push(webpage)
    webpage
  end
end
