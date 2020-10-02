# frozen_string_literal: true

module Sudoku
  class Simple
    def initialize(grid)
      @grid = grid
    end

    def solve(line, column)
      line, column = next_empty_cell(line, column)
      return true if line.nil?

      (1..9).to_a.each do |value|
        next if conflict?(line, column, value)

        @grid[line][column] = value
        return true if solve(line, column)

        @grid[line][column] = 0
      end

      false
    end

    def output_grid
      9.times do |line|
        9.times do |column|
          print " #{@grid[line][column]}"
          print ' |' if column % 3 == 2
        end
        print "\n"
        puts '-' * 25 if line % 3 == 2
      end
    end

    def simple_grid
      @grid.map { |line| line.join(' ') }.join("\n")
    end

    private

    def next_empty_cell(line, column)
      loop do
        loop do
          return [line, column] if @grid[line][column].zero?

          column += 1
          break if column >= 9
        end
        line += 1
        column = 0
        break if line >= 9
      end
    end

    def conflict?(line, column, value)
      line_values(line).include?(value) ||
        column_values(column).include?(value) ||
        subgrid_values(line, column).include?(value)
    end

    def line_values(line)
      @grid[line]
    end

    def column_values(column)
      @grid.map { |line| line[column] }
    end

    def subgrid_values(line, column)
      values = []
      subgrid_line = line / 3
      subgrid_column = column / 3
      3.times do |i|
        3.times do |j|
          values << @grid[subgrid_line * 3 + i][subgrid_column * 3 + j]
        end
      end
      values
    end
  end
end
