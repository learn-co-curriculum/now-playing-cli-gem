require 'open-uri'
require 'pry'
require 'nokogiri'

require "now_playing/version"
require "now_playing/movie"

module NowPlaying
  class CLI
    def call

      start
    end

    def list
      puts "Now Playing in Theatres\n"
      Movie.all.each.with_index(1) do |movie, i|
        puts "#{i}. #{movie.name}"
      end
    end

    def start
      list
      input = nil
      while input != "exit"
        puts "What movie would you more information on, by name or number?"
        puts "Enter list to see the movies again."
        puts "Enter exit to end the program."
        input = gets.strip
        if input == "list"
          list
        elsif input.to_i == 0
          if movie = Movie.find_by_name(input)
            puts movie.url
          end
        elsif input.to_i > 0
          if movie = Movie.find(input.to_i)
            puts movie.url
          end
        end
      end
      puts "Goodbye!!!"
    end
  end
end
