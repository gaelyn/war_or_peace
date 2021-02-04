require 'minitest/autorun'
require 'minitest/pride'
require './lib/deck'
require './lib/card'
require './lib/player'
require './lib/turn'

class TurnTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)
    @turn = Turn.new(@player1, @player2)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
    assert_equal @turn.player1, @player1
    assert_equal @turn.player2, @player2
  end

  def test_player_starts_with_no_spoils_of_war
    assert_equal @turn.spoils_of_war, []
  end

  def test_turn_type
    assert_equal @turn.type, :basic
  end

  def test_there_is_a_winner
    assert_equal @turn.winner, @player1
  end

  def test_pile_cards
    assert_equal @turn.pile_cards, @turn.spoils_of_war
  end

  def test_spoils_are_awarded_to_winner
    @turn.award_spoils(@player1)
    # require "pry"; binding.pry

    assert_equal @player1.deck.cards, [@card2, @card5, @card8, @card1, @card3]
    assert_equal @player2.deck.cards, [@card4, @card6, @card7]
  end
end
