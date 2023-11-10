require "open-uri"
class GamesController < ApplicationController

  def new
    @letters = (1..10).map { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word]).upcase
    # checking the number of time letters use in the words are <= to letters
    @include =  @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    @english_word = english_word?(@word)
  end

  private
  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
