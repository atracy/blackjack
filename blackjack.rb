# Encoding: utf-8

# Card Class
class Card
  attr_accessor :state, :used, :points, :suite
  def initialize(pnts, suit, isused)
    self.used = false
    self.points = pnts
    self.suite = suit
    self.used = isused
  end

  # def getpoints
  #   return @points
  # end

  # def getsuite
  #   return @suite
  # end

  # def isused
  #   return @used
  # end

  # def setused(state)
  #   @used = state
  # end

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
      if d.used == false

        d.used = true
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

class Hand

  def initialize

    @points = 0
    @cards = []
    @haveace = false
  end

  def getcard(anothercard)

    @cards.push anothercard

    if anothercard.points == 'jack' ||

      anothercard.points == 'queen' ||
      anothercard.points == 'king'
      @points = @points.to_i + 10

    elsif anothercard.points == 'Ace'

      @haveace = true

    else

    @points = @points.to_i + anothercard.points.to_i

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

  def to_s

    @cards.each do |c|
      if self.name == 'dealer'
        puts "Dealer has the #{c.points} of #{c.suite}"
      else
        puts "You got the #{c.points} of #{c.suite}"
      end
    end

  end

end

# Person Class
class Person < Hand
  attr_accessor :name

end

class BlackJack
  def initialize

    @deck = Deck.new
    @player = Person.new
    @dealer = Person.new
    @dealer.name = 'dealer'

  end

  def play
    welcomeplayer
    setupgame
    offermorecards
    dealersturn
    determinewinner
  end

  private
  def welcomeplayer
    print 'Hi! Welcome to Blackjack!  What''s your name? '
    @player.name = gets.chomp!

  end

  def setupgame
    puts "the #{@dealer.name} is shuffling the cards"
    @deck.shuffle
    puts "The #{@dealer.name} is dealing the cards"

    @player.getcard @deck.getcard
    @dealer.getcard @deck.getcard
    @player.getcard @deck.getcard
    @dealer.getcard @deck.getcard

    @player.to_s

  end

  def offermorecards
    anothercard = 'y'

    while anothercard == 'y'

      print "you now have #{@player.getpoints}"
      puts ' points do you want another card? (y/n)'
      anothercard = gets.chomp!

      if anothercard == 'y'

        curcard = @deck.getcard
        @player.getcard curcard
        puts 'The dealer hands you a card'
        print "you turn it over and find it's the #{curcard.points} "
        puts " of #{curcard.suite}"

        if @player.getpoints > 21

          puts "You went over 21 with #{@player.getpoints} points"
          break

        end
      end
    end
  end

  def dealersturn
    puts 'The dealer turns over his cards'
    @dealer.to_s


    while
      @dealer.getpoints <= 17

      puts 'he then grabs a card from the deck for himself'
      curcard = @deck.getcard
      @dealer.getcard @deck.getcard
      print "he draws a #{curcard.points} of #{curcard.suite}"
      puts  " for a total of #{@dealer.getpoints} points"
    end
  end

  def determinewinner
    puts "dealer has #{@dealer.getpoints} and you have #{@player.getpoints}"

    if @dealer.getpoints > 21 && @player.getpoints > 21

      puts 'A Bust!  Both were over!'


    elsif  @dealer.getpoints == @player.getpoints

      puts 'It was a tie! No one wins'

    elsif @dealer.getpoints == 21
      puts "Sorry #{@player.name}, You Lose!"

    elsif (@player.getpoints > @dealer.getpoints && @player.getpoints <= 21) ||
      (@dealer.getpoints > 21 && @player.getpoints <= 21)

      puts "Congratulations #{@player.name}!!!!  You win!!!!!"

    else

      puts "Sorry #{@player.name}, You Lose!"

    end
  end
end

bj = BlackJack.new
bj.play







