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

playerHand = []
cpuHand = []

26.times do |n|
  r = rand(deck.length)
  playerHand.push(deck[r])
  deckOfCards.deck.delete_at(r)
end

26.times do |n|
  r = rand(deck.length)
  cpuHand.push(deck[r])
  deckOfCards.deck.delete_at(r)
end

continue = true

while continue == true
  STDOUT.flush
  # continue = false
  if playerHand[0].number > cpuHand[0].number
    puts "Your #{playerHand[0].number} of #{playerHand[0].suit} beats Computer's #{cpuHand[0].number} of #{cpuHand[0].suit}!"
    player_card = playerHand[0]
    cpu_card = cpuHand[0]
    playerHand.delete_at(0)
    cpuHand.delete_at(0)
    playerHand.push(player_card)
    playerHand.push(cpu_card)
  elsif playerHand[0].number < cpuHand[0].number
    puts "Computer's #{cpuHand[0].number} of #{cpuHand[0].suit} beats your #{playerHand[0].number} of #{playerHand[0].suit}!"
    player_card = playerHand[0]
    cpu_card = cpuHand[0]
    playerHand.delete_at(0)
    cpuHand.delete_at(0)
    cpuHand.push(player_card)
    cpuHand.push(cpu_card)
  else
    card_number = 0
    loss = true
    while loss
      loss = false
      puts "Your #{playerHand[card_number].number} of #{playerHand[card_number].suit} and Computer's #{cpuHand[card_number].number} of #{cpuHand[card_number].suit} have tied!"
      puts "War! Place down 3 cards and show the 4th, winner takes all the cards."
      card_number = card_number + 4
      if playerHand.length <= 4 || cpuHand.length <= 4
        if playerHand.length <= 4
          puts "You lose since you don't have enough cards!"
          continue = false
        elsif cpuHand.length <= 4
          puts "The computer loses since they don't have enough cards!"
          continue = false
        end
      elsif playerHand[card_number].number > cpuHand[card_number].number && playerHand.length > 4 && cpuHand.length > 4
        puts "Your #{playerHand[card_number].number} of #{playerHand[card_number].suit} beats Computer's #{cpuHand[card_number].number} of #{cpuHand[card_number].suit}!"
        playerHand[0..card_number].each do |x|
          playerHand.push(x)
        end
        cpuHand[0..card_number].each do |x|
          playerHand.push(x)
        end
        (card_number + 1).times do
          playerHand.delete_at(0)
          cpuHand.delete_at(0)
        end
      elsif playerHand[card_number].number < cpuHand[card_number].number && playerHand.length > 4 && cpuHand.length > 4
        puts "Computer's #{cpuHand[card_number].number} of #{cpuHand[card_number].suit} beats your #{playerHand[card_number].number} of #{playerHand[card_number].suit}!"
        playerHand[0..card_number].each do |x|
          cpuHand.push(x)
        end
        cpuHand[0..card_number].each do |x|
          cpuHand.push(x)
        end
        (card_number + 1).times do
          playerHand.delete_at(0)
          cpuHand.delete_at(0)
        end
      else
        loss = true
      end
    end
  end
  puts "You currently have #{playerHand.length} cards."
  puts "CPU currently has #{cpuHand.length} cards."
  # puts "Would you like to continue? Type yes if so."
  # response = gets.chomp.to_s
  # if response == "yes"
  #   continue = true
  # end
  if playerHand.length == 0
    puts "The computer won, tough luck."
    continue = false
  elsif cpuHand.length == 0
    puts "Congratulations, you win!"
    continue = false
  end
  playerHand = playerHand.shuffle
  cpuHand = cpuHand.shuffle

end
