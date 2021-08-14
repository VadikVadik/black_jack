# frozen_string_literal: true

class Game
  attr_accessor :bank, :players, :card_deck
  attr_reader :player, :dealer

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @bank = 0
    @players = [player, dealer]
    @card_deck = [
      { nominal: 2, title: "2+" }, { nominal: 2, title: "2<3" },
      { nominal: 2, title: "2^" }, { nominal: 2, title: "2<>" },
      { nominal: 3, title: "3+" }, { nominal: 3, title: "3<3" },
      { nominal: 3, title: "3^" }, { nominal: 3, title: "3<>" },
      { nominal: 4, title: "4+" }, { nominal: 4, title: "4<3" },
      { nominal: 4, title: "4^" }, { nominal: 4, title: "4<>" },
      { nominal: 5, title: "5+" }, { nominal: 5, title: "5<3" },
      { nominal: 5, title: "5^" }, { nominal: 5, title: "5<>" },
      { nominal: 6, title: "6+" }, { nominal: 6, title: "6<3" },
      { nominal: 6, title: "6^" }, { nominal: 6, title: "6<>" },
      { nominal: 7, title: "7+" }, { nominal: 7, title: "7<3" },
      { nominal: 7, title: "7^" }, { nominal: 7, title: "7<>" },
      { nominal: 8, title: "8+" }, { nominal: 8, title: "8<3" },
      { nominal: 8, title: "8^" }, { nominal: 8, title: "8<>" },
      { nominal: 9, title: "9+" }, { nominal: 9, title: "9<3" },
      { nominal: 9, title: "9^" }, { nominal: 9, title: "9<>" },
      { nominal: 10, title: "10+" }, { nominal: 10, title: "10<3" },
      { nominal: 10, title: "10^" }, { nominal: 10, title: "10<>" },
      { nominal: 10, title: "V+" }, { nominal: 10, title: "V<3" },
      { nominal: 10, title: "V^" }, { nominal: 10, title: "V<>" },
      { nominal: 10, title: "D+" }, { nominal: 10, title: "D<3" },
      { nominal: 10, title: "D^" }, { nominal: 10, title: "D<>" },
      { nominal: 10, title: "K+" }, { nominal: 10, title: "K<3" },
      { nominal: 10, title: "K^" }, { nominal: 10, title: "K<>" },
      { nominal: 11, alt_nominal: 1, title: "T+" },
      { nominal: 11, alt_nominal: 1, title: "T<3" },
      { nominal: 11, alt_nominal: 1, title: "T^" },
      { nominal: 11, alt_nominal: 1, title: "T<>" }
    ]
  end

  def deal_cards
    players.each do |player|
      self.card_deck += player.cards
      player.nullify!
      2.times { add_card(player) }
    end
  end

  def add_card(player)
    new_card = card
    player.cards << new_card
    player.points += if new_card.key?(:alt_nominal) && (player.points + new_card[:nominal]) > 21
                       new_card[:alt_nominal]
                     else
                       new_card[:nominal]
                     end
  end

  def card
    new_card = card_deck.sample
    card_deck.delete(new_card)
    new_card
  end

  def bid(player, amount)
    self.bank += amount
    player.deposit -= amount
  end

  def dealer_move
    dealer.points >= 17 ? return : add_card(dealer)
  end

  def vin(player)
    player.deposit += bank
    self.bank = 0
    player.status = 1
  end

  def draw
    players.each { |player| player.deposit += (self.bank / 2) }
    self.bank = 0
  end

  def draw?
    player.points == dealer.points || (player.points > 21 && dealer.points > 21)
  end

  def end_game
    if draw?
      draw
    elsif !player.excess? && dealer.excess? || (player.points > dealer.points && !player.excess?)
      vin(player)
    elsif player.excess? && !dealer.excess? || (player.points < dealer.points && !dealer.excess?)
      vin(dealer)
    end
  end
end
