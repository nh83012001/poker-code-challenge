require "rails_helper"
require "poker"

describe Poker do
  # Testing methods that provide hands keys
  describe ".flush?" do
    context "given an array of suits that all match" do
      it "returns true" do
        expect(Poker.flush?(['C','C','C','C','C'])).to eql(true)
      end
    end
    context "given an array of suits that do not match" do
      it "returns false" do
        expect(Poker.flush?(['C','C','C','H','C'])).to eql(false)
      end
    end
  end
  describe ".uniqueValues" do
    context "given an array of card values it will tell unique amount" do
      it "returns count of uniqe cards in hand" do
        expect(Poker.uniqueValues([13,8,13,2,4])).to eql(4)
      end
    end
  end
  describe ".straight?" do
    context "given an array of card values tells if you have a straight" do
      it "returns true" do
        expect(Poker.straight?([6,7,8,9,10])).to eql(true)
      end
    end
    context "given an array of card values tells if you have a straight" do
      it "returns false" do
        expect(Poker.straight?([2,3,4,5,10])).to eql(false)
      end
    end
    context "it can handle ace as low for A-5 straight" do
      it "returns true" do
        expect(Poker.straight?([2,3,4,5,14])).to eql(true)
      end
    end
  end
  describe ".pair?" do
    context "given an array of card values tells if you have a pair" do
      it "returns object with keys of cards and values of cards count" do
        expect(Poker.pair?([5,5,14,14,9])).to eql({5=>2, 14=>2, 9=>1})
      end
    end
    context "given an array of card values tells if you have a pair" do
      it "returns false" do
        expect(Poker.pair?([2,3,4,5,10])).to eql(false)
      end
    end
  end
  describe ".largestPair" do
    context "given an object of key values for a hand with a pair returns " do
      it "returns array of card values with higest pair" do
        expect(Poker.largestPair({8=>3, 14=>2})).to eql([8,3])
      end
    end
    context "given an object of key values for a hand with a pair returns" do
      it "returns array of card values with highest pair" do
        expect(Poker.largestPair({5=>2, 14=>2, 9=>1})).to eql([[14,2],[5,2]])
      end
    end
  end
  describe ".descendingValue" do
    context "given an array of card values" do
      it "returns descending array" do
        expect(Poker.descendingValue([2,2,13,13,8])).to eql([13,13,8,2,2])
      end
    end
  end


# Testing method that consumes hand and decides rank
  describe ".rank" do
    context "given a hand object with no pair" do
      it "returns a 1" do
        expect(Poker.rank({:hand=>["7C", "8C", "5C", "QD", "6C"], :descendingValue=>[12, 8, 7, 6, 5], :flush=>false, :straight=>false, :pair=>false, :largestPair=>1, :uniqueValues=>5})).to eql(1)
      end
    end
    context "given a hand object with one pair" do
      it "returns a 2" do
        expect(Poker.rank({:pair=>{12=>1, 7=>1, 4=>2, 2=>1}, :largestPair=>[4, 2], :uniqueValues=>4})).to eql(2)
      end
    end
    context "given a hand object with two pair" do
      it "returns a 3" do
        expect(Poker.rank({:pair=>{12=>1, 7=>2, 4=>2}, :largestPair=>[[7,2][4,2]], :uniqueValues=>3})).to eql(3)
      end
    end
    context "given a hand object with three of a kind" do
      it "returns a 4" do
        expect(Poker.rank({:pair=>{12=>1, 7=>1, 4=>3}, :largestPair=>[4, 3], :uniqueValues=>3})).to eql(4)
      end
    end
    context "given a hand object with a straight and no flush" do
      it "returns a 5" do
        expect(Poker.rank({:straight=>true, :flush=>false, :largestPair => [4, 2]})).to eql(5)
      end
    end
    context "given a hand object with a flush but no straight" do
      it "returns a 6" do
        expect(Poker.rank({:straight=>false, :flush=>true, :largestPair => [4, 2]})).to eql(6)
      end
    end
    context "given a hand object with a full house" do
      it "returns a 7" do
        expect(Poker.rank({:straight=>false, :flush=>false, :largestPair => [4, 3],:uniqueValues =>2})).to eql(7)
      end
    end
    context "given a hand object with four of a kind" do
      it "returns a 8" do
        expect(Poker.rank({:straight=>false, :flush=>false, :largestPair => [10, 4],:uniqueValues =>2})).to eql(8)
      end
    end
    context "given a hand object a straight flush not up to Ace" do
      it "returns a 9" do
       expect(Poker.rank({:straight=>true, :flush=>true, :largestPair => [10, 4],:uniqueValues =>2, :descendingValue=>[12,11,10,9,8]})).to eql(9)
      end
    end
    context "given a hand object with a royal flush" do
      it "returns a 10" do
        expect(Poker.rank({:straight=>true, :flush=>true, :largestPair => [10, 4],:uniqueValues =>2, :descendingValue=>[14,13,12,11,10]})).to eql(10)
      end
    end
  end

end
