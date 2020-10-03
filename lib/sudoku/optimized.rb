# frozen_string_literal: true

module Sudoku
  class Optimized < Simple
    def initialize(grid)
      super
      setup_viable_values
    end

    def solve(line, column)
      line, column = next_empty_cell(line, column)
      return true if line.nil?

      viable_values = @grid[line][column]
      viable_values.each do |value|
        next if conflict?(line, column, value)

        @grid[line][column] = value
        return true if solve(line, column)

        @grid[line][column] = viable_values
      end

      false
    end

    private

    def setup_viable_values
      9.times do |line|
        9.times do |column|
          next if @grid[line][column] != 0

          viable_values = []
          (1..9).each do |value|
            next if conflict?(line, column, value)

            viable_values << value
          end
          @grid[line][column] = viable_values
        end
      end
    end

    def next_empty_cell(line, column)
      loop do
        loop do
          return [line, column] if @grid[line][column].is_a?(Array)

          column += 1
          break if column >= 9
        end
        line += 1
        column = 0
        break if line >= 9
      end
    end
  end
end
