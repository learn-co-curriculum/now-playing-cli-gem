class NowPlaying::Movie
  attr_accessor :name, :url, :summary, :stars

  def initialize(name = nil, url = nil)
    @name = name
    @url = url
  end

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

  def summary
    @summary ||= plot_summary_doc.search("#plot-summaries-content p").text.strip
  end

  def stars
    @stars ||= doc.search("#titleCast span[itemprop='name']").collect{|e| e.text.strip}.join(", ")
  end

  private
    def self.scrape_now_playing
      doc = Nokogiri::HTML(open('https://www.imdb.com/movies-in-theaters/'))
      names = doc.search("h4[itemprop='name'] a[itemprop='url']")
      names.collect{|e| new(e.text.strip, "https://imdb.com#{e.attr("href").split("?").first.strip}")}
    end

    def plot_summary_doc
      @plot_summary_doc ||= Nokogiri::HTML(open("#{self.url}plotsummary"))
    end

    def doc
      @doc ||= Nokogiri::HTML(open(self.url))
    end

end
