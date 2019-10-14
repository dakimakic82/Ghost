class Player 
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess
      puts "Enter a letter to guess"
      gets.chomp.downcase
    end

    def alert_invalid_guess
      puts "You made an invalid guess!"
    end
end