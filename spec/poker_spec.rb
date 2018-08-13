require "rails_helper"
require "poker"
# RSpec.describe
describe Poker do
  describe ".flush?" do
    context "given an array of suits that all match" do
      it "returns true" do
        expect(Poker.flush?(['C','C','C','C','C'])).to eql(true)
      end
    end
  end

  describe ".flush?" do
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
  end

  describe ".straight?" do
    context "it can handle ace as low for A-5 straight" do
      it "returns true" do
        expect(Poker.straight?([2,3,4,5,14])).to eql(true)
      end
    end
  end

  describe ".straight?" do
    context "given an array of card values tells if you have a straight" do
      it "returns false" do
        expect(Poker.straight?([2,3,4,5,10])).to eql(false)
      end
    end
  end

  describe ".pair?" do
    context "given an array of card values tells if you have a pair" do
      it "returns object with keys of cards and values of cards count" do
        expect(Poker.pair?([5,5,14,14,9])).to eql({5=>2, 14=>2, 9=>1})
      end
    end
  end

  describe ".pair?" do
    context "given an array of card values tells if you have a pair" do
      it "returns false" do
        expect(Poker.pair?([2,3,4,5,10])).to eql(false)
      end
    end
  end

  describe ".largestPair" do
    context "given an object of key values for a hand with a pair returns " do
      it "returns card value of highest pair" do
        expect(Poker.largestPair({8=>3, 14=>2})).to eql([8,3])
      end
    end
  end

  describe ".largestPair" do
    context "given an object of key values for a hand with a pair returns" do
      it "returns card value of highest pair" do
        expect(Poker.largestPair({5=>2, 14=>2, 9=>1})).to eql([14,2])
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

  describe ".rank" do
    context "given a hand object" do
      it "returns a 1-10 ranking" do
        expect(Poker.rank({:hand=>["7C", "8C", "5C", "QD", "6C"], :descendingValue=>[12, 8, 7, 6, 5], :flush=>false, :straight=>false, :pair=>false, :largestPair=>1, :uniqueValues=>5})).to eql(1)
      end
    end
  end





end
