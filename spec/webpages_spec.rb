# frozen_string_literal: true

require_relative '../lib/webpages'

RSpec.describe Webpages do
  let(:webpages) { Webpages.new }

  it 'creates a webpages class' do
    expect(webpages).to be_kind_of(Webpages)
  end

  context 'add page view' do
    subject(:two_page_views_for_one_page) {
      webpages.add_page_view({
        page_path: '/index',
        ip: '200.017.277.774'
      })
      webpages.add_page_view({
        page_path: '/index',
        ip: '802.683.925.780'
      })
      webpages
    }

    it 'adds a new page' do
      webpages.add_page_view({
        page_path: '/index',
        ip: '200.017.277.774'
      })

      expect(webpages.list.length).to eq(1)
    end

    it 'does not add a new page if path is the same' do
      expect(two_page_views_for_one_page.list.length).to eq(1)
    end

    it 'adds a page view to existing page' do
      expect(two_page_views_for_one_page.list.first.page_view_count).to eq(2)
    end

    it 'does not add a new unique page view if IP is the same' do
      webpages.add_page_view({
        page_path: '/index',
        ip: '200.017.277.774'
      })
      webpages.add_page_view({
        page_path: '/index',
        ip: '200.017.277.774'
      })

      expect(webpages.list.first.unique_page_view_count).to eq(1)
    end
  end

  context 'sorting' do
    subject(:webpages_for_sort) {
      webpages.add_page_view({
        page_path: '/index',
        ip: '200.017.277.774'
      })
      webpages.add_page_view({
        page_path: '/contact',
        ip: '200.017.277.774'
      })
      webpages.add_page_view({
        page_path: '/index',
        ip: '200.017.277.774'
      })
      webpages.add_page_view({
        page_path: '/index',
        ip: '802.683.925.780'
      })
      webpages.add_page_view({
        page_path: '/contact',
        ip: '802.683.925.780'
      })
      webpages.add_page_view({
        page_path: '/index',
        ip: '802.683.925.780'
      })
      webpages.add_page_view({
        page_path: '/contact',
        ip: '451.106.204.921'
      })
      webpages
    }

    it 'gets sorted list of webpages by page views' do
      expect(webpages_for_sort.sorted_by_page_views.map(&:path)).to eq(['/index', '/contact'])
    end

    it 'gets sorted list of webpages by unique page views' do
      expect(webpages_for_sort.sorted_by_unique_page_views.map(&:path)).to eq(['/contact', '/index'])
    end
  end
end
