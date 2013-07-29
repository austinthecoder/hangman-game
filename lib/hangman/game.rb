require 'hangman'

module Hangman
  class Game
    def initialize(word)
      @word = word
      @guesses = Set.new
    end

    attr_reader :guesses, :word

    def guess(letter)
      raise GameOverError, 'Cannot guess: game is over' if status != :in_progress
      guesses << letter
    end

    def incorrect_guesses
      guesses.select { |l| !word_letters.include? l }
    end

    def status
      if incorrect_guesses.size < 6
        if word_letters.all? { |l| guesses.include? l }
          :won
        else
          :in_progress
        end
      else
        :lost
      end
    end

    def ==(other)
      other.is_a?(self.class) && guesses == other.guesses && word == other.word
    end

    private

    def word_letters
      @word_letters ||= word.split('').tap(&:uniq!)
    end
  end
end