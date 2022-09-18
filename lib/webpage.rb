# frozen_string_literal: true

class Webpage
  attr_reader :path, :page_view_count, :unique_page_views

  def initialize page_path
    @path = page_path
    @page_view_count = 0
    @unique_page_views = []
  end

  def add_page_view ip
    @page_view_count += 1
    @unique_page_views.push(ip) unless unique_page_views.include?(ip)
  end

  def unique_page_view_count
    unique_page_views.count
  end
end
