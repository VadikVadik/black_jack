class ResultPrinter

  attr_accessor :game

  def initialize(game)
    @game = game
  end

  def separator
    45.times { print '=' }
    puts
  end

  def print_status
    system("clear") || system("cls")
    puts "***В банке игры: #{game.bank}$***"
    separator
    puts "#{game.player.name}, Ваши карты:"
    game.player.cards.each { |card| puts "#{card[:title]}" }
    separator
    puts "Ваши очки: #{game.player.points}, Ваш депозит: #{game.player.deposit}$"
    separator
    amount = game.dealer.cards.size
    puts "Дилер:"
    amount.times {puts "*"}
  end

  def print_result
    vinner = game.players.select { |player| player.status == 1 }
    system("clear") || system("cls")
    separator
    puts "***Ничья***" if vinner.empty?
    puts "***Победил: #{vinner[0].name}***" if !vinner.empty?
    separator
    puts "#{game.player.name}, Ваши карты:"
    game.player.cards.each { |card| puts "#{card[:title]}" }
    separator
    puts "Ваши очки: #{game.player.points}, Ваш депозит: #{game.player.deposit}$"
    separator
    puts "Дилер:"
    game.dealer.cards.each { |card| puts "#{card[:title]}" }
    separator
    puts "Очки дилера: #{game.dealer.points}, депозит дилера: #{game.dealer.deposit}$"
    separator
  end

  def move
    puts "1. Пропустить ход
2. Добавить карту
3. Открыть карты"
  user_input = gets.chomp.to_i
  user_input
  end

end
