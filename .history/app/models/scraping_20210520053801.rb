class Scraping < ApplicationRecord
require 'mechanize'

  def self.scrape
    agent = Mechanize.new                  #agentは任意の変数
    page = agent.get("https://loconavi.jp/features/hananomeisho")  #pageは任意の変数 getの引数はサイトのURL
    elements_name = page.search('div.name') #div.idxcol aは取得したい要素  elementsは任意の変数
    elements_name.each do |element|
      flower_items = FlowerItem.new                      #Fishは任意のクラス、fishは任意のインスタンス
      flower_items.name = element.inner_text
      flower_items.save
    end
  end
end
