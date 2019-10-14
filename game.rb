require 'set'
require_relative 'player'



class Game
    
    ALPHABET = Set.new("a".."z")

    def initialize(player_1, player_2) #how to swap players 1 and 2 if we set atr to (*players)
        words = File.new("dictionary.txt").map(&:chomp)
        @dictionary = Set.new(words)    #Set implements a collection of unordered values with no duplicates. 
                                     #This is a hybrid of Array's intuitive inter-operation facilities and Hash's fast lookup.
        @player_1 = Player.new(player_1) # class
        @player_2 = Player.new(player_2)
        @fragment = ""
        @losses = Hash.new { |losses, player| losses[player] = 0 }
        #@losses = Hash.new(0) ** This might also work\
    
    end

      def play_round
        @fragment = ""
        until round_over?
            puts "#{current_player.name}'s turn:"
            take_turn(current_player)
            puts "The current fragment is #{@fragment}"
            next_player
        end
    losses
    end

    def valid_play?(letter)
       return false unless ALPHABET.include?(letter)
       maybe_an_answer = @fragment + letter
       @dictionary.any? { |word| word.start_with?(maybe_an_answer) }
    end
    
    def current_player
        @player1
    end

    def previous_player
        @player2
    end

    def next_player
     @player1, @player2 = @player2, @player1 # simple swaping 
    end

  

    def run
        play_round until game_over?
        loser = @losses.key(5).name # this will give us the name of the loser
        # Hash.key(value) will find the key that has the given value
        puts "The game is over! #{loser} loses the game!"
    end

    def game_over?
        @losses.any? { |key, value| value == 5 }
    end

    def round_over?
        @dictionary.include?(@fragment)
    end

    def take_turn(player)
        answer = player.guess
        until valid_play?(answer)
            player.alert_invalid_guess
            answer = player.guess
        end
        @fragment += answer
    end
     

    def losses # count of losses
        @losses[previous_player] += 1
    end

    def display_standings
        @losses.each do |key, value|
            puts "#{key.name} has #{value} losses"
        end
    end
end

game = Game.new("Ben", "Dalibor")
game.run
