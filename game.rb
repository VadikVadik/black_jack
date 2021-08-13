require_relative 'player.rb'

class Game

  attr_accessor :bank, :players, :card_deck
  attr_reader :player, :diler

  def initialize(player, diler)
      @player = player
      @diler = diler
      @bank = 0
      @players = [player, diler]
      @card_deck = [
        {nominal: 2, title: "2+"}, {nominal: 2, title: "2<3"},
        {nominal: 2, title: "2^"}, {nominal: 2, title: "2<>"},
        {nominal: 3, title: "3+"}, {nominal: 3, title: "3<3"},
        {nominal: 3, title: "3^"}, {nominal: 3, title: "3<>"},
        {nominal: 4, title: "4+"}, {nominal: 4, title: "4<3"},
        {nominal: 4, title: "4^"}, {nominal: 4, title: "4<>"},
        {nominal: 5, title: "5+"}, {nominal: 5, title: "5<3"},
        {nominal: 5, title: "5^"}, {nominal: 5, title: "5<>"},
        {nominal: 6, title: "6+"}, {nominal: 6, title: "6<3"},
        {nominal: 6, title: "6^"}, {nominal: 6, title: "6<>"},
        {nominal: 7, title: "7+"}, {nominal: 7, title: "7<3"},
        {nominal: 7, title: "7^"}, {nominal: 7, title: "7<>"},
        {nominal: 8, title: "8+"}, {nominal: 8, title: "8<3"},
        {nominal: 8, title: "8^"}, {nominal: 8, title: "8<>"},
        {nominal: 9, title: "9+"}, {nominal: 9, title: "9<3"},
        {nominal: 9, title: "9^"}, {nominal: 9, title: "9<>"},
        {nominal: 10, title: "10+"}, {nominal: 10, title: "10<3"},
        {nominal: 10, title: "10^"}, {nominal: 10, title: "10<>"},
        {nominal: 10, title: "V+"}, {nominal: 10, title: "V<3"},
        {nominal: 10, title: "V^"}, {nominal: 10, title: "V<>"},
        {nominal: 10, title: "D+"}, {nominal: 10, title: "D<3"},
        {nominal: 10, title: "D^"}, {nominal: 10, title: "D<>"},
        {nominal: 10, title: "K+"}, {nominal: 10, title: "K<3"},
        {nominal: 10, title: "K^"}, {nominal: 10, title: "K<>"},
        {nominal: 11, alt_nominal: 1, title: "T+"},
        {nominal: 11, alt_nominal: 1, title: "T<3"},
        {nominal: 11, alt_nominal: 1, title: "T^"},
        {nominal: 11, alt_nominal: 1, title: "T<>"}
      ]
  end

  def deal_cards
    players.each { |player| 2.times { add_card(player) } }
  end

  def add_card(player)
    new_card = card
    player.cards << new_card
    if new_card.key?(:alt_nominal) && (player.points + new_card[:nominal]) > 21
      player.points += new_card[:alt_nominal]
    else
      player.points += new_card[:nominal]
    end
  end

  def bid(player, amount)
      self.bank += amount
      player.deposit -= amount
  end

  def vin(player)
    player.deposit += bank
    bank = 0
  end

  protected

  def card
    new_card = card_deck.sample
    card_deck.delete(new_card)
    return new_card
  end

end
