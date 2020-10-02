# frozen_string_literal: true

gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require_relative '../lib/sudoku'

class SudokuTest < Minitest::Test
  def test_simple
    Dir.foreach("#{__dir__}/problems") do |filename|
      next if ['.', '..'].include?(filename)

      problem_path = "#{__dir__}/problems/#{filename}"
      solution_path = "#{__dir__}/tmp_solution.txt"

      Sudoku.run('1', problem_path, solution_path)

      expected_solution = File.read("#{__dir__}/solutions/#{filename}")
      calculated_solution = File.read(solution_path)

      assert_equal expected_solution, calculated_solution
    end
  end

  def test_optimized
    Dir.foreach("#{__dir__}/problems") do |filename|
      next if ['.', '..'].include?(filename)

      problem_path = "#{__dir__}/problems/#{filename}"
      solution_path = "#{__dir__}/tmp_solution.txt"

      Sudoku.run('2', problem_path, solution_path)

      expected_solution = File.read("#{__dir__}/solutions/#{filename}")
      calculated_solution = File.read(solution_path)

      assert_equal expected_solution, calculated_solution
    end
  end

  Minitest.after_run do
    File.delete("#{__dir__}/tmp_solution.txt") if File.exist?("#{__dir__}/tmp_solution.txt")
  end
end
