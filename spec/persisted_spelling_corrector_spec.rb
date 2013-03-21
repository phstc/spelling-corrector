require "spec_helper"

describe PersistedSpellingCorrector do
  subject(:corrector) { PersistedSpellingCorrector.new }

  describe "#correct" do
    let(:word) { "pablo" }
    let(:correction) { "table" }

    context "persisted" do
      before do
        PersistedSpellingCorrector.stub(:where).with(word: word).
          and_return [double("word", correction: correction)]
      end

      it "returns a persisted correction" do
        expect(corrector.correct word).to eq correction
      end

      it "should not call non-persisted corrector" do
        SpellingCorrector.any_instance.should_not_receive :correct

        corrector.correct word
      end
    end

    context "non-persisted" do
      before do
        PersistedSpellingCorrector.stub(:where).with(word: word).
          and_return []

        PersistedWordCollection.any_instance.stub nwords: []

        SpellingCorrector.any_instance.stub(:correct).with(word).and_return(correction)
      end

      it "return a non-persisted correction" do
        PersistedSpellingCorrector.stub :create

        expect(corrector.correct word).to eq correction
      end

      it "persists a non-persisted correction" do
        PersistedSpellingCorrector.should_receive(:create).
          with(word: word, correction: correction)
        corrector.correct word
      end
    end
  end
end
