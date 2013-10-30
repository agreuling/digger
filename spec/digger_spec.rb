require 'spec_helper'

describe Digger do
  describe "returns a value" do
    it "from a shallow array" do
      data = [ 1, 3, 7]
      expect(Digger.dig_chain(data, 2)).to eq 7
    end

    it "from a deep array" do
      data = [ 1, [2, [3, 4, 5]]]
      expect(Digger.dig_chain(data, 1, 1, 2)).to eq 5
    end

    it "from a shallow hash" do
      data = {cheese: :provolone}
      expect(Digger.dig_chain(data, :cheese)).to eq :provolone
    end

    it "from a deep hash" do
      data = {book: {chapter: {page: :word}}}
      expect(Digger.dig_chain(data, :book, :chapter, :page)).to eq :word
    end

    it "from a hash-array combo" do
      data = [:blank, {farm: [{pig: :pink}, {horse: :brown}, {cow: :black}]}]
      expect(Digger.dig_chain(data, 1, :farm, 2, :cow)).to eq :black
    end
  end

  describe "returns a collection" do
    it "returns a hash when applicable" do
      data = [2, {frog: :green}, 3]
      expect(Digger.dig_chain(data, 1)).to eq frog: :green
    end

    it "returns an array when applicable" do
      data = {bagels: [:salt, :plain, :garlic, :everything]}
      expect(Digger.dig_chain(data, :bagels)).to eq [:salt, :plain, :garlic, :everything]
    end

    it "returns a hash-array combo when applicable" do
      data = [{spices: [:salt, :pepper, :tumeric]}]
      expect(Digger.dig_chain(data, 0)).to eq spices: [:salt, :pepper, :tumeric]
    end
  end

  describe "returns default values" do
    it "returns block result for a bad array index" do
      data = [1]
      expect(Digger.dig_chain(data, 2) {2+3+5}).to eq 10
    end

    it "returns block result for a bad hash key" do
      data = {good: :stuff}
      expect(Digger.dig_chain(data, :bad) {"OOOOOH"}).to eq "OOOOOH"
    end

    it "returns nil for a bad array index with no block given" do
      data = [1]
      expect(Digger.dig_chain(data, 2)).to be_nil
    end

    it "returns nil for a bad hash key with no block given" do
      data = {good: :stuff}
      expect(Digger.dig_chain(data, :bad)).to be_nil
    end

    it "returns nil if data is not fetch-able" do
      data = Object.new
      expect(Digger.dig_chain(data, :whatever)).to be_nil
    end
  end

end
