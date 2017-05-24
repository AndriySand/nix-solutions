class ParserWorker
  include Sidekiq::Worker
  require 'nokogiri'
  require 'open-uri'

  def perform
    start_url = URI.parse('https://news.ycombinator.com/')
    page = Nokogiri::HTML(open(start_url))
    page.xpath("//tr[@class='athing']/td[@class='title'][2]/a").each do |link|
      title = link.content.gsub(/â\u0080\u0099|â\u0080\u0098/, "'")
      next if Post.find_by_title(title)
      url_str = link['href'][/http(s?):\/\//] ? link['href'] : 'https://news.ycombinator.com/' + link['href']
      url = URI.parse(url_str)
      page = Nokogiri::HTML(open(url))
      next if page.content.include? 'browser must accept cookies'
      content = ''
      author = false
      page.xpath('//h1','//h2','//a','//p','//span','//h3').each do |el|
        author = el.content if !author && el.attributes.detect{|k, v| v.value.include? 'author'}
        next if el.content[/\A\n\s*.+\s+\z/] || el.content[/\A\s+\z/]
        next if el.children.detect{|child| child.text == el.content}
        content += el.content
      end
      author ||= 'Someone'
      Post.create(title: title, body: content, author: author, url: url_str)
    end
  end
end
