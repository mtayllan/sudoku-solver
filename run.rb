# frozen_string_literal: true

require_relative './lib/sudoku'

algorithm = ARGV[0]
input_file_path = ARGV[1]
output_file_path = ARGV[2]

Sudoku.run(algorithm, input_file_path, output_file_path)
