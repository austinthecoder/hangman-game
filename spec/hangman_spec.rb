require 'spec_helper'
require_relative '../lib/hangman'

describe Hangman do
  describe '.new_game' do
    it 'returns a new Hangman::Game with a random word from the word list' do
      Hangman.word_list = ['foo']
      expect(Hangman.new_game).to eq(Hangman::Game.new('foo'))
    end
  end
end