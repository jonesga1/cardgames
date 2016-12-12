require './card.rb'
require './deck.rb'

number = [1,2,3,4,5,6,7,8,9,10,11,12,13]
deck = []

number.each do |card|
  deck.push(Card.new(card, "Diamonds"))
  deck.push(Card.new(card, "Clubs"))
  deck.push(Card.new(card, "Spades"))
  deck.push(Card.new(card, "Hearts"))
end

deckOfCards = Deck.new(deck)

discards = []
playerHand = []
cpuHand = []

5.times do |n|
  r = rand(deck.length)
  playerHand.push(deck[r])
  deckOfCards.deck.delete_at(r)
end

5.times do |n|
  r = rand(deck.length)
  cpuHand.push(deck[r])
  deckOfCards.deck.delete_at(r)
end

r = rand(deck.length)
discards.push(deck[r])
deckOfCards.deck.delete_at(r)

def draw(hand)
  hand.push(deckOfCards.deck[0])
  deckOfCards.deck.delete_at(0)
end

def showHand(hand)
  puts "You currently have:"
  hand.each do |card|
    puts "#{card.number} of #{card.suit}"
  end
  puts ""
end

def showTop(discards)
  puts ""
  puts "#{discards[-1].number} of #{discards[-1].suit} is the current top card."
  puts ""
end


#:D
def playableCardFinder(hand, discards)
  playableCards = []
  hand.each do |card|
    if card.number == 8 || card.suit == discards[-1].suit || card.number == discards[-1].number && card.suit != discards[-1].suit
      playableCards.push(card)
    end
  end
  return playableCards
end
#:D end

def putsPlayableCards(playableCards)
  if playableCards.length == 0
    puts "You don't have any cards to play!"
  else
    puts "Your playable cards are:"
    playableCards.each do |card|
      puts "#{card.number} of #{card.suit}"
    end
  end
  puts ""
end

def playerPlay(playableCards,playerHand,deck,discards)
  if playableCards.length == 0
    puts "You were forced to draw!"
    puts "You drew the #{deck[0].number} of #{deck[0].suit}!"
    playerHand.push(deck[0])
    deck.delete_at(0)
  else
    puts "Which card to do want to play?"
    number = gets.chomp.to_i
    suit = gets.chomp
    n = 0
    playerHand.each do |card|
      if card.number == number && card.suit == suit
        if card.number == 8
          puts "What suit would you like the 8 to be?"
          suitChange = gets.chomp
          card.suit = suitChange
        end
        discards.push(card)
        playerHand.delete_at(n)
      end
      n = n + 1
    end
  end
end

def showCPUHand(hand)
  puts "Computer currently has:"
  hand.each do |card|
    puts "#{card.number} of #{card.suit}"
  end
  puts ""
end

def cpuPlay(cpuHand, discards, deck, playableCards)
  showCPUHand(cpuHand)
  if playableCards.length == 0
    puts "The computer was forced to draw!"
    puts "The computer drew the #{deck[0].number} of #{deck[0].suit}!"
    cpuHand.push(deck[0])
    deck.delete_at(0)
  elsif playableCards.length > 0
    foundCard = true
    cpuHand.each do |card|

    end
    playableCards.each do |card|
      if foundCard == true
        if card.number == discards[-1].number && card.number != 8 || card.suit == discards[-1].suit
          puts "The computer played the #{card.number} of #{card.suit}!"
          discards.push(card)
          keepCounting = true
          n = 0
          cpuHand.each do |card|
            if card.number == discards[-1].number && card.number != 8 || card.suit == discards[-1].suit
              keepCounting = false
            elsif keepCounting == true
              n = n + 1
            end
          end
          cpuHand.delete_at(n)
          foundCard = false
        elsif card.number == 8
          keepCounting = true
          n = 0
          cpuHand.each do |card|
            if card.number == 8
              keepCounting = false
            elsif keepCounting == true
              n = n + 1
            end
          end
          puts "The computer played the #{card.number} of #{card.suit}!"
          r = rand(3)
          if r == 0
            card.suit = "Diamonds"
          elsif r == 1
            card.suit = "Hearts"
          elsif r == 2
            card.suit = "Clubs"
          elsif r == 3
            card.suit = "Spades"
          end
          puts "The 8 becomes #{card.suit}!"
          discards.push(card)
          cpuHand.delete_at(n)
          foundCard = false
        end
      end
    end
  end
end

continue = true

while continue == true
  continue = false
  STDOUT.flush
  puts "**************************************"
  puts "Computer currently has #{cpuHand.length} card(s)."
  puts "You currently have #{playerHand.length} card(s)."
  puts ""
  showHand(playerHand)
  showTop(discards)
  putsPlayableCards(playableCardFinder(playerHand, discards))
  playerPlay(playableCardFinder(playerHand, discards), playerHand, deckOfCards.deck, discards)
  if playerHand.length == 0 || cpuHand.length == 0
    continue = false
  else
    continue = true
  end
  showTop(discards)
  cpuPlay(cpuHand, discards, deckOfCards.deck, playableCardFinder(cpuHand, discards))
  #:c
  if playerHand.length == 0 || cpuHand.length == 0
    continue = false
  else
    continue = true
  end
  #:c end
end

if cpuHand.length == 0
  puts "The computer won! Sucks to suck."
elsif playerHand.length == 0
  puts "You won, congratulations!"
end
