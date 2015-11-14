class Movie
  attr_accessor :name, :url

  def self.all
    @@all ||= scrape_now_playing
  end

  def self.find(id)
    self.all[id-1]
  end

  def self.find_by_name(name)
    self.all.detect do |m|
      m.name.downcase.strip == name.downcase.strip ||
      m.name.split("(").first.strip.downcase == name.downcase.strip
    end
  end

  def self.scrape_now_playing
    doc = Nokogiri::HTML(open('http://www.imdb.com/movies-in-theaters/'))
    names = doc.search("h4[itemprop='name'] a[itemprop='url']")
    names.collect{|e| Movie.new(e.text, "http://imdb.com#{e.attr("href")}")}
  end

  def initialize(name = nil, url = nil)
    @name = name
    @url = url
  end
end
