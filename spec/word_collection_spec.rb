# encoding: utf-8

require "spec_helper"

describe WordCollection do
  before do
    WordCollection.any_instance.stub untrained_collection_text: File.new(File.expand_path("../fixtures/holmes.txt", __FILE__)).read
  end

  subject(:word_collection) { WordCollection.new }

  describe "#words" do
    it "converts to downcase and removes any non-word character" do
      expect(word_collection.words "OI Óí PaBlO").to eq %w(oi pablo)
    end
  end

  describe "#train" do
    it "counts how many times each word occurs" do
      expect(word_collection.train(%w(oi oi pablo))).to eq ({"oi" => 3, "pablo" => 2})
    end
  end
end

