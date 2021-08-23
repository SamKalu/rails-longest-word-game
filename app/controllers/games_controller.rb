require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @alphabet = ("A".."Z").to_a
    @rand_letters = []
    10.times { @rand_letters << @alphabet.sample }
    @rand_letters
  end
  
  def score
    @rand_letters = params[:rand_letters].split
    @word = params[:word].upcase
    @english_word = parse(@word)
    @included = includes_letters(@rand_letters, @word)
  end
  
  def parse(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user = JSON.parse(URI.open(url).read)
    user['found']
  end

  def includes_letters(rand_letters, word)
    word.chars.all? { |letter| word.count(letter) <= rand_letters.count(letter) }
  end
end
