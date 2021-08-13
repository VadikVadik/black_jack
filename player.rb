class Player

  attr_accessor :deposit, :cards, :points
  attr_reader :name

  def initialize(name, deposit = 100)
    @name = name
    @deposit = deposit
    @cards = []
    @points = 0
  end

end
