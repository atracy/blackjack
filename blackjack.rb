# Encoding: utf-8

# Card Class
class Card
  attr_writer :state
  def initialize(pnts, suit, isused)
    @used = false
    @points = pnts
    @suite = suit
    @used = isused
  end

  def getpoints
    return @points
  end

  def getsuite
    return @suite
  end

  def isused
    return @used
  end

  def setused(state)
    @used = state
  end

end
# Deck Class
class Deck
  def initialize
    @deck = []

    self.loadnumbercards
    self.loadclubroyalty
    self.loadheartsroyalty
    self.loaddiamondsroyalty
    self.loadspadesroyalty

  end

  def shuffle
    @deck.shuffle!
    @deck.shuffle!
  end

  def getcard

    @deck.each do |d|
      if d.isused == false

        d.setused true
        return d
      end
    end

  end

  def loadnumbercards

    j = 0

    9.times do
      j += 1
      @deck.push Card.new((j + 1).to_s, 'spades', false)
      @deck.push Card.new((j + 1).to_s, 'hearts', false)
      @deck.push Card.new((j + 1).to_s, 'diamonds', false)
      @deck.push Card.new((j + 1).to_s, 'clubs', false)
    end

  end

  def loadclubroyalty

    @deck.push Card.new('jack', 'clubs', false)
    @deck.push Card.new('queen', 'clubs', false)
    @deck.push Card.new('king', 'clubs', false)
    @deck.push Card.new('Ace', 'clubs', false)
  end

  def loadheartsroyalty

    @deck.push Card.new('jack', 'hearts', false)
    @deck.push Card.new('queen', 'hearts', false)
    @deck.push Card.new('king', 'hearts', false)
    @deck.push Card.new('Ace', 'hearts', false)
  end

  def loaddiamondsroyalty

    @deck.push Card.new('jack', 'diamonds', false)
    @deck.push Card.new('queen', 'diamonds', false)
    @deck.push Card.new('king', 'diamonds', false)
    @deck.push Card.new('Ace', 'diamonds', false)
  end

  def loadspadesroyalty
    @deck.push Card.new('jack', 'spades', false)
    @deck.push Card.new('queen', 'spades', false)
    @deck.push Card.new('king', 'spades', false)
    @deck.push Card.new('Ace', 'spades', false)
  end
end

# Person Class
class Person

  def initialize(personname)
    @name = personname
    @points = 0
    @cards = []
    @haveace = false
  end

  def getname
    return @name
  end

  def getcard(anothercard)
    @cards.push anothercard
    if anothercard.getpoints == 'jack' ||
      anothercard.getpoints == 'queen' ||
      anothercard.getpoints == 'king'
    @points = @points.to_i + 10
  elsif anothercard.getpoints == 'Ace'
    @haveace = true
  else
    @points = @points.to_i + anothercard.getpoints.to_i
    end
  end

  def getpoints
    if @haveace == true
      if @points > 21 || (@points + 11) > 21
        temppoints = @points + 1
      else
        temppoints = @points + 11
      end
      return temppoints
    else
      return @points
    end
  end
end

@deck = Deck.new

print 'Hi! Welcome to Blackjack!  What''s your name? '

name = gets.chomp!

player = Person.new name
dealer = Person.new 'dealer'

puts "the #{dealer.getname} is shuffling the cards"

@deck.shuffle

puts "The #{dealer.getname} is dealing the cards"

card1 = @deck.getcard
dcard1 = @deck.getcard
card2 = @deck.getcard
dcard2 = @deck.getcard

puts "You got the #{card1.getpoints} of #{card1.getsuite}"
puts "you also got the #{card2.getpoints} of #{card2.getsuite}"

player.getcard card1
dealer.getcard dcard1
player.getcard card2
dealer.getcard dcard2

anothercard = 'y'

while anothercard == 'y'

  print "you now have #{player.getpoints}"
  puts ' points do you want another card? (y/n)'
  anothercard = gets.chomp!

  if anothercard == 'y'

    curcard = @deck.getcard
    player.getcard curcard
    puts 'The dealer hands you a card'
    print "you turn it over and find it's the #{curcard.getpoints} "
    puts " of #{curcard.getsuite}"

    if player.getpoints > 21

      puts "You went over 21 with #{player.getpoints} points"
      break

    end
  end
end

puts 'The dealer turns over his cards'
puts "He has a #{dcard1.getpoints} of #{dcard1.getsuite}"
puts "He has a #{dcard2.getpoints} of #{dcard2.getsuite}"

while dealer.getpoints <= 17

  puts 'he then grabs a card from the deck for himself'
  curcard = @deck.getcard
  dealer.getcard @deck.getcard
  print "he draws a #{curcard.getpoints} of #{curcard.getsuite}"
  puts  " for a total of #{dealer.getpoints} points"
end

puts "dealer has #{dealer.getpoints} and you have #{player.getpoints}"

if dealer.getpoints > 21 && player.getpoints > 21

  puts 'A Bust!  Both were over!'


elsif  dealer.getpoints == player.getpoints

  puts 'It was a tie! No one wins'

elsif dealer.getpoints == 21
  puts "Sorry #{player.getname}, You Lose!"

elsif (player.getpoints > dealer.getpoints && player.getpoints <= 21) ||
  (dealer.getpoints > 21 && player.getpoints <= 21)

  puts "Congratulations #{player.getname}!!!!  You win!!!!!"

else


end

