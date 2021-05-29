class Scraping < ApplicationRecord
  require 'mechanize'
  require 'nokogiri'
    # 花データを取得してDBに保存
    # def self.flower_item_scrape
    #   agent = Mechanize.new
    #   page = agent.get("https://loconavi.jp/features/hananomeisho")
    #   names = page.search('.name')
    #   features = page.search('.description')
    #   images = page.images_with(:src => /jpg\Z/)

    #   FlowerItem.transaction do
    #     names.each_with_index do |name, index|
    #       FlowerItem.create!(name: name.inner_text, feature: features[index].inner_text, image: images[index])
    #     end
    #   end
    # end

    # スポットデータを取得してDBに保存
    # def self.spot_scrape
    #   agent = Mechanize.new
    #   page = agent.get()
    # end

    def self.flower_item_scrape
      agent = Mechanize.new
      base_url = 'https://loconavi.jp'
      page = agent.get("#{base_url}/features/hananomeisho")
      # 取得したいページへ遷移
      # pages = agent.page.link_with(:dom_class => "flower").click
      pages = page.search('.flower')
      href = page[:href]
      # pages.each do | page |
      #   links = page[:href]
      # end

      link_url = "#{base_url}#{href}"
      page = agent.get(link_url)
      names = page.search('.flower-description h1')
      puts names.inner_text

        # names = page.search('.flower-description h1')
        # features = page.search('.text p')
        # images = page.images_with(:src => /jpg\Z/)

        # FlowerItem.transaction do
        #   names.each_with_index do |name, index|
        #     FlowerItem.create!(name: name.inner_text, feature: features[index].inner_text, image: images[index])
        #   end
        # end
    end
    # def self.flower_item_scrape
    #   agent = Mechanize.new
    #   base_url = 'https://loconavi.jp'
    #   page = agent.get("#{base_url}/features/hananomeisho")
    #   # 取得したいページへ遷移
    #   page = agent.page.link_with(:dom_class => "flower").click

    #   names = page.search('.flower-description h1')
    #   features = page.search('.text p')
    #   images = page.images_with(:src => /jpg\Z/)

    #   FlowerItem.transaction do
    #     names.each_with_index do |name, index|
    #       FlowerItem.create!(name: name.inner_text, feature: features[index].inner_text, image: images[index])
    #     end
    #   end
    # end
  end