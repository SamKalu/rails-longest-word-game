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
    @rand_letters = params[:rand_letters].split(" ")
    @word = (params[:word] || "").upcase
    @english_word = parse(@word)
    @included = includes_letters(@word, @letters)
  end
  
  def parse(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    @user = JSON.parse(response.read)
    @user['found']
  end

  def includes_letters(rand_letters, word)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end




# def game
#   includes_letters(@rand_letters)
#   if @condition = false
#     @answer = "Sorry but #{@word.upcase} can't be built out of #{@rand_letters.flatten}"
#   elsif @user['found'] == true
#     @answer = "Congratulations! #{@word.upcase} is a valid English word!"
#   end
# end