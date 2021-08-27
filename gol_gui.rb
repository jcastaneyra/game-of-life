require 'gosu'
require_relative 'game_of_life.rb'

INTERVAL_MILLISECONDS = 500
class GOLGui < Gosu::Window
  def initialize(height=1000, width=1000)
    super height, width, false, INTERVAL_MILLISECONDS
    self.caption = "Game of Life GUI"
    
    @background = Gosu::Color.new(0xffdedede)
    @alive = Gosu::Color.new(0xff121212)
    @dead = Gosu::Color.new(0xffededed)

    @rows = 100
    @cols = 100
    # @gol = GameOfLife.new(@rows,@cols, [[0,1,0,0,0],[0,0,1,0,0],[1,1,1,0,0],[0,0,0,0,0],[0,0,0,0,0]])
    @gol = GameOfLife.new(@rows,@cols)
    @board = @gol.board

    @row_height = height/@rows
    @col_width = width/@cols
    @generation = 0

  end
  
  def update
    @generation += 1
    puts "Generation #{@generation}"
    @gol.run_generation
  end
  
  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    # when Gosu::MsLeft
      # process_click
    end
  end

  def draw
    draw_background
    for row in 0...@rows
      for col in 0...@cols
        if @board[row][col] == 0
          draw_quad(col * @col_width, row * @row_height, @dead,
                  col * @col_width + (@col_width - 1), row * @row_height, @dead,
                  col * @col_width + (@col_width - 1), row * @row_height + (@row_height - 1), @dead,
                  col * @col_width, row * @row_height + (@row_height - 1), @dead)
        else
          draw_quad(col * @col_width, row * @row_height, @alive,
                  col * @col_width + (@col_width - 1), row * @row_height, @alive,
                  col * @col_width + (@col_width - 1), row * @row_height + (@row_height - 1), @alive,
                  col * @col_width, row * @row_height + (@row_height - 1), @alive)
        end
      end
    end
  end

  def draw_background
    draw_quad(0, 0, @background,
              width, 0, @background,
              width, height, @background,
              0, height, @background)
  end
end

GOLGui.new.show