# frozen_string_literal: true

require_relative './sudoku/simple'
require_relative './sudoku/optimized'

module Sudoku
  SIMPLE = '1'
  OPTIMIZED = '2'

  def self.run(algorithm, input_file_path, output_file_path)
    grid = []
    File.foreach(input_file_path) do |line|
      grid << line.chomp.split(' ').map(&:to_i)
    end

    sudoku = if algorithm == SIMPLE
               Sudoku::Simple.new(grid)
             elsif algorithm == OPTIMIZED
               Sudoku::Optimized.new(grid)
             else
               raise 'Invalid algorithm option'
             end

    solved = sudoku.solve(0, 0)
    solution = sudoku.simple_grid if solved

    if !solved
      raise 'Can not solve this sudoku'
    end

    File.write(output_file_path, solution)
  end
end
