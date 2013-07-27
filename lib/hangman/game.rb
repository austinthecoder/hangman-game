module Hangman
  class Game
    def initialize(word)
      @word = word
      @guesses = Set.new
    end

    attr_reader :guesses, :word

    def guess(letter)
      guesses << letter
    end

    def ==(other)
      other.is_a?(self.class) && guesses == other.guesses && word == other.word
    end
  end
end