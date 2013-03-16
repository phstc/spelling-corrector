# encoding: utf-8

require "spec_helper"

describe SpellingCorrectorCollection do
  before do
    SpellingCorrectorCollection.any_instance.stub words_collection: File.new(File.expand_path("../fixtures/holmes.txt", __FILE__)).read
  end

  subject(:collection) { SpellingCorrectorCollection.new }

  describe "#words" do
    it "converts to downcase and removes any non-word character" do
      expect(collection.words "OI Óí PaBlO").to eq %w(oi pablo)
    end
  end

  describe "#train" do
    it "counts how many times each word occurs" do
      expect(collection.train(%w(oi oi pablo))).to eq ({"oi" => 3, "pablo" => 2})
    end
  end
end

