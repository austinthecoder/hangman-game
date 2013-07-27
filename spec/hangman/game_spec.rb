require 'spec_helper'
require_relative '../../lib/hangman/game'

module Hangman
  describe Game do
    it 'marshals' do
      game = Game.new 'foo'
      game.guess 'a'

      unmarshaled_game = Marshal.load(Marshal.dump(game))

      expect(game).to eq(unmarshaled_game)
    end

    describe '#word' do
      it 'is the given word' do
        Game.new('foo').word.should == 'foo'
      end
    end

    describe '#guesses' do
      it { expect(Game.new('foo').guesses).to be_empty }
    end

    describe '#guess' do
      context 'when the letter was already guessed' do
        it 'does not change the list of guesses' do
          game = Game.new('foo')
          game.guess 'a'
          expect { game.guess 'a' }.to_not change { game.guesses }
        end
      end

      context 'when the letter was not already guessed' do
        it 'adds the letter to the list of guesses' do
          game = Game.new('foo')
          game.guess 'a'
          expect(game.guesses).to include('a')
        end
      end
    end

    describe '#incorrect_guesses' do
      it 'a list of incorrectly guessed letters' do
        game = Game.new('hangman')
        game.guess 'a'
        game.guess 'x'
        expect(game.incorrect_guesses).to_not include('a')
        expect(game.incorrect_guesses).to include('x')
      end
    end

    describe '#status' do
      let(:game) { Game.new 'hangman' }

      context 'when there are 6 incorrect guesses' do
        it 'is :lost' do
          %w[x y z q f h a n g l].each { |l| game.guess l }
          expect(game.status).to eq :lost
        end
      end

      context 'when there is less than 6 incorrect guesses' do
        context 'when all letters were guessed' do
          it 'is :won' do
            %w[x y z q f h a n g m].each { |l| game.guess l }
            expect(game.status).to eq :won
          end
        end

        context 'when all letters were not guessed' do
          it 'is :in_progress' do
            %w[x y z q f h a n g].each { |l| game.guess l }
            expect(game.status).to eq :in_progress
          end
        end
      end
    end

    describe '#==' do
      it 'is true given another Hangman game with the same word & guesses' do
        game = Game.new('foo')
        game.guess 'a'

        other_game = Game.new('foo')
        other_game.guess 'a'

        expect(game).to eq(other_game)
      end

      it 'is false given another Hangman game with different guesses' do
        game = Game.new('foo')
        game.guess 'a'

        other_game = Game.new('foo')
        other_game.guess 'b'

        expect(game).to_not eq(other_game)
      end

      it 'is false given another Hangman game with a different word' do
        game = Game.new('foo')
        game.guess 'a'

        other_game = Game.new('bar')
        other_game.guess 'a'

        expect(game).to_not eq(other_game)
      end
    end
  end
end