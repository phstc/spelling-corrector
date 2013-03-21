require "spec_helper"

describe Levenshtein do

  describe "#self.distance" do
    context "assumes ins=2, del=2, sub=1" do
      sample_words = [
        OpenStruct.new(word: "sheeeeep"    , other: "sheep"      , distance: 6),
        OpenStruct.new(word: "peepple"     , other: "people"     , distance: 3),
        OpenStruct.new(word: "inSIDE"      , other: "inside"     , distance: 4),
        OpenStruct.new(word: "jjoobbb"     , other: "job"        , distance: 8),
        OpenStruct.new(word: "weke"        , other: "wake"       , distance: 1),
        OpenStruct.new(word: "CUNsperrICY" , other: "conspiracy" , distance: 9)
      ]

      sample_words.each do |sample|
        it "calculates the distance from #{sample.word} to #{sample.other}" do
          expect(Levenshtein.distance sample.word, sample.other).to eq sample.distance
        end
      end
    end
  end
end

