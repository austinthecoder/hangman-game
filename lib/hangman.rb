require "hangman/version"
require 'hangman/game'

module Hangman
  class Error < StandardError
  end

  class GameOverError < Error
  end

  class << self
    attr_accessor :word_list

    def new_game
      Game.new word_list.shuffle[0]
    end
  end
end
