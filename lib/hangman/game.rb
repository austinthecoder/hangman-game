module Hangman
  class Game
    def initialize
      @guesses = Set.new
    end

    attr_reader :guesses

    def guess(letter)
      guesses << letter
    end

    def ==(other)
      other.is_a?(self.class) && guesses == other.guesses
    end
  end
end