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

    def incorrect_guesses
      guesses.select { |l| !word_letters.include? l }
    end

    def status
      return :lost unless incorrect_guesses.size < 6
      word_letters.all? { |l| guesses.include? l } ? :won : :in_progress
    end

    def ==(other)
      other.is_a?(self.class) && guesses == other.guesses && word == other.word
    end

    private

    def word_letters
      @word_letters ||= word.split ''
    end
  end
end