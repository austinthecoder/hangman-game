require "hangman/version"
require 'hangman/game'

module Hangman
  class << self
    attr_writer :word_list

    def new_game
      Game.new
    end
  end
end
