require 'spec_helper'

RSpec.describe NowPlaying::Movie do
  context 'Class Methods' do
    # If you delete the fixtures or VCR generates new cassettes these tests
    # will have to be updated based on current values from:
    # http://www.imdb.com/movies-in-theaters/
    around(:each) do |example|
      VCR.use_cassette("now-playing") do
        example.run
      end
    end
    let(:movies){NowPlaying::Movie.all}

    describe '.all' do
      it 'returns an array of movies' do
        expect(movies).to be_an(Array)
        expect(movies.first).to be_a(NowPlaying::Movie)
      end

      it 'correctly scrapes names and urls for the movies' do
        expect(movies.first.name).to eq("The 33 (2015)")
        expect(movies.first.url).to eq("http://imdb.com/title/tt2006295/")
      end
    end

    describe '.find' do
      it 'returns the movie based on position in @@all' do
        expect(NowPlaying::Movie.find(1)).to eq(movies[0])
      end
    end

    describe '.find_by_name' do
      it 'returns the movie based on the name' do
        expect(NowPlaying::Movie.find_by_name("The 33")).to eq(movies[0])
      end
    end
  end

  context 'Instance Methods' do
    subject{NowPlaying::Movie.new("The 33 (2015)", "http://imdb.com/title/tt2006295/")}

    describe '#name' do
      it 'has a name' do
        expect(subject.name).to eq("The 33 (2015)")
      end
    end

    describe '#url' do
      it 'has a url' do
        expect(subject.url).to eq("http://imdb.com/title/tt2006295/")
      end
    end

    describe '#stars' do
      it 'has stars based on scraping the main URL' do
        VCR.use_cassette("movie") do
          expect(subject.stars).to eq("Antonio Banderas, Rodrigo Santoro, Juliette Binoche")
        end
      end
    end

    describe '#summary' do
      it 'has a summary based on scraping the plotsummary URL' do
        VCR.use_cassette("plotsummary") do
          expect(subject.summary).to eq("Based on the real-life event, when a gold and copper mine collapses, it traps 33 miners underground for 69 days.")
        end
      end
    end
  end
end
