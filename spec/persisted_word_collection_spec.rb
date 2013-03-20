require "spec_helper"

describe PersistedWordCollection do
  subject(:persisted_word_collection) { PersistedWordCollection.new }

  describe "#nwords" do
    let(:nwords) do
      {"job" => 1}
    end

    let(:word_entry) { OpenStruct.new word: "job", rank: 1 }

    context "looking for persisted data" do
      it "returns nwords" do
        PersistedWordCollection.stub all: [word_entry]
        expect(persisted_word_collection.nwords).to eq nwords
      end
    end

    context "loading data to persist" do
      before do
        PersistedWordCollection.stub all: []
        WordCollection.stub untrained_collection_text: ""
        WordCollection.any_instance.stub nwords: nwords
      end

      it "persists data" do
        PersistedWordCollection.should_receive(:create).with({word: "job", rank: 1})
        persisted_word_collection.nwords
      end

      it "returns nwords" do
        PersistedWordCollection.stub(:create).with({word: "job", rank: 1})
        expect(persisted_word_collection.nwords).to eq nwords
      end
    end
  end
end

