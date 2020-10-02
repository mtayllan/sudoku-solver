# frozen_string_literal: true

require_relative './sudoku/simple'
require_relative './sudoku/optimized'

module Sudoku
  SIMPLE = '1'
  OPTIMIZED = '2'

  def self.run(algorithm, input_file_path, output_file_path)
    p input_file_path
    grid = []
    File.foreach(input_file_path) do |line|
      grid << line.chomp.split(' ').map(&:to_i)
    end

    solution = []

    case algorithm
    when SIMPLE
      sudoku = Sudoku::Simple.new(grid)
      sudoku.solve(0, 0)
      solution = sudoku.simple_grid
    when OPTIMIZED
      sudoku = Sudoku::Optimized.new(grid)
      sudoku.solve(0, 0)
      solution = sudoku.simple_grid
    else
      raise 'Invalid algorithm option'
    end

    File.write(output_file_path, solution)
  end
end
