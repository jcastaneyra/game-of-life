# 1. Any live cell with two or three live neighbours survives.
# 2. Any dead cell with three live neighbours becomes a live cell.
# 3. All other live cells die in the next generation. Similarly, all other dead cells stay dead.

class GameOfLife
    attr_reader :board

    def initialize(rows, cols, input = nil)
        if !input
            @board = Array.new(rows) { Array.new(cols) { rand(2)} }
        else
            @board = input
        end
    end

    def run_generation()
        rows = @board.size
        cols = @board[0].size
        neighbors = [[0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1]]

        for row in 0 ... rows
            for col in 0 ... cols

                counter = 0
                neighbors.each do |elem|
                    r = row + elem[0]
                    c = col + elem[1]

                    if (r < rows and r >= 0) and (c < cols and c >= 0) and (@board[r][c]).abs == 1
                        counter += 1
                    end
                end

                if @board[row][col] == 1 and (counter < 2 or counter > 3)
                    @board[row][col] = -1
                end

                if @board[row][col] == 0 and counter == 3
                    @board[row][col] = 2
                end
            end
        end

        for row in 0 ... rows
            for col in 0 ... cols
                if @board[row][col] > 0
                    @board[row][col] = 1
                else
                    @board[row][col] = 0
                end
            end
        end
                
    end

    def print_board
        print @board
        puts
    end

end

#game = GameOfLife.new(5,5, [[0,1,0],[0,0,1],[1,1,1],[0,0,0]])
#game.print_board
#game.run_generation
#game.print_board