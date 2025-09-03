require 'nokogiri'
require 'open-uri'

class ScraperService
  SITE_URL = 'https://thehackernews.com/'

  def self.scrape_latest_news
    doc = Nokogiri::HTML(URI.open(SITE_URL))
    articles = doc.css('a.story-link').first(5)
    news_list = []
    articles.each do |article|
      title = article.css('h2.home-title').text.strip
      summary = article.css('div.home-desc').text.strip
      link = article['href']
      news_list << { title: title, summary: summary, link: link }
    end
    news_list
  end
end
