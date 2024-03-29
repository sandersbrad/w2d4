require_relative 'board'
require_relative 'player'
require_relative 'display'
require_relative 'computerplayer'


class Game
  def initialize
    @board = Board.new
    @display = Display.new(board)
    @red = Player.new("Brad", :red, board, display)
    @white = ComputerPlayer.new("Jimmy", :white, board, display)
    @current_player = red
  end

  def play
    until board.won?
      begin
        current_player.take_turn
      rescue InvalidMove => e
        puts e.message
        sleep(1)
        retry
      rescue GreatJump => e
        puts e.message
        sleep(1)
        retry
      end
      switch_player
    end
  end

  private

    attr_reader :board, :display, :red, :white
    attr_accessor :current_player

    def switch_player
      self.current_player = current_player == red ? white : red
    end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
