class GamesController < ApplicationController

  def new
    alphabet = ("A".."Z").to_a
    @rand_letters = alphabet.shuffle.first(10)
  end

  def score
  end
end
