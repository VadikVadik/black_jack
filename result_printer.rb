# frozen_string_literal: true

class ResultPrinter
  attr_accessor :game

  def initialize(game)
    @game = game
  end

  def separator
    40.times { print '=' }
    puts
  end

  def print_process
    game.start_game
    system("clear") || system("cls")
    separator
    puts "***В БАНКЕ ИГРЫ: #{game.bank}$***"
    separator
    puts "#{game.player.name}, Ваши карты:"
    game.player.cards.each { |card| puts (card[:title]).to_s }
    separator
    puts "Ваши очки: #{game.player.points}, Ваш депозит: #{game.player.deposit}$"
    separator
    amount = game.dealer.cards.size
    puts "Дилер:"
    amount.times { puts "*" }
    separator
    game.main_game(move)
  end

  def print_result
    vinner = game.players.select { |player| player.status == 1 }
    system("clear") || system("cls")
    separator
    puts "***Ничья***" if vinner.empty?
    puts "***Победил: #{vinner[0].name}***" unless vinner.empty?
    separator
    puts "#{game.player.name}, Ваши карты:"
    game.player.cards.each { |card| puts (card[:title]).to_s }
    separator
    puts "Ваши очки: #{game.player.points}, Ваш депозит: #{game.player.deposit}$"
    separator
    puts "Дилер:"
    game.dealer.cards.each { |card| puts (card[:title]).to_s }
    separator
    puts "Очки дилера: #{game.dealer.points}, депозит дилера: #{game.dealer.deposit}$"
    separator
  end

  def move
    puts "***ВЫБЕРИТЕ ДЕЙСТВИЕ***
1. Пропустить ход
2. Добавить карту
3. Открыть карты"
    gets.chomp.to_i
  end
end
