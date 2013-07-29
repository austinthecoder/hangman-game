require 'spec_helper'
require_relative '../lib/hangman'

describe Hangman do
  describe Hangman::Error do
    it { expect(Hangman::Error.new).to be_a StandardError  }
  end

  describe Hangman::GameOverError do
    it { expect(Hangman::GameOverError.new).to be_a Hangman::Error  }
  end

  describe '.new_game' do
    it 'returns a new Hangman::Game with a random word from the word list' do
      Hangman.word_list = ['foo']
      expect(Hangman.new_game).to eq(Hangman::Game.new('foo'))
    end
  end
end