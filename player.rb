# frozen_string_literal: true

class Player
  attr_accessor :deposit, :cards, :points, :status
  attr_reader :name

  def initialize(name, deposit = 100)
    @name = name
    @deposit = deposit
    @cards = []
    @points = 0
    @status = 0
  end

  def excess?
    points > 21
  end

  def nullify!
    cards.clear
    self.points = 0
    self.status = 0
  end
end
