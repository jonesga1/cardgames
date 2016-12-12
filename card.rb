class Card
  def initialize(number, suit)
    @suit = suit
    @number = number
  end

  attr_accessor :number, :suit
end
