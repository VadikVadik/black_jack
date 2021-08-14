# frozen_string_literal: true

require_relative 'game'
require_relative 'player'
require_relative 'result_printer'

puts "Введите своё имя"
user_name = gets.chomp

user = Player.new(user_name)
dealer = Player.new("Дилер")

game = Game.new(user, dealer)
printer = ResultPrinter.new(game)

loop do
  printer.start_game
  next_move = printer.move
  printer.main_game(next_move)

  puts "Играть еще? 1. Да 2. Нет"
  user_input = gets.chomp.to_i
  break if user_input == 2
end
