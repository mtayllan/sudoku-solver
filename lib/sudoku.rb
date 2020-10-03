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

    solution = []

    if algorithm == SIMPLE
      sudoku = Sudoku::Simple.new(grid)
      solved = sudoku.solve(0, 0)
      solution = sudoku.simple_grid if solved
    elsif algorithm == OPTIMIZED
      sudoku = Sudoku::Optimized.new(grid)
      solved = sudoku.solve(0, 0)
      solution = sudoku.simple_grid if solved
    else
      raise 'Invalid algorithm option'
    end

    if !solved
      raise 'Can not solve this sudoku'
    end

    File.write(output_file_path, solution)
  end
end
