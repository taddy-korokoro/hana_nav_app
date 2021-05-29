class Scraping < ApplicationRecord
require 'mechanize'

  def self.scrape
    agent = Mechanize.new                  #agentは任意の変数
    page = agent.get("https://loconavi.jp/features/hananomeisho")  #pageは任意の変数 getの引数はサイトのURL

    name = page.at('.name').inner_text if page.at('.name')
    feature = page.at('.description').inner_text if page.at('.description')
    image = page.at('.flower-image img')[:src] if page.at('.flower-image img')

    folwer_items = FlowerItem.new
    folwer_items.name = name
    folwer_items.feature = feature
    folwer_items.image = image

    folwer_items.save
  end
end
