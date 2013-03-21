require "spec_helper"

describe SpellingCorrector do

  before do
    # WordCollection.any_instance.stub untrained_collection_text: File.new(File.expand_path("../fixtures/holmes.txt", __FILE__)).read
  end

  subject(:corrector) { SpellingCorrector.new }

  describe "#known" do
    it "returns known words" do
      expect(corrector.known %w(can)).to eq %w(can)
    end

    it "returns nil for unknown words" do
      expect(corrector.known %w("ornithorhyncus")).to be_nil
    end
  end

  describe "#correct" do
    it "corrects a word" do
      expect(corrector.correct "cen").to eq "can"
    end

    it "returns NO SUGGESTION for unknown words" do
      expect(corrector.correct "ornithorhyncus").to eq "NO SUGGESTION"
    end

    context "sample words" do
      words_hash = {
        "sheeeeep"    => "sheep",
        "peepple"     => "people",
        "sheeple"     => "NO SUGGESTION",
        "inSIDE"      => "inside",
        "jjoobbb"     => "job",
        "weke"        => "wake",
        "CUNsperrICY" => "conspiracy"
      }

      words_hash.keys.each do |incorrect_word|
        it "corrects #{incorrect_word} to #{words_hash[incorrect_word]}" do
          expect(corrector.correct incorrect_word).to eq words_hash[incorrect_word]
        end
      end
    end
  end

  describe "#edits1" do
    it "returns all word transformations" do
      corrector.stub deletes: %w(a)
      corrector.stub transposes: %w(b)
      corrector.stub replaces: %w(c)
      corrector.stub inserts: %w(d)
      expect(corrector.edits1 "oi").to eq %w(a b c d)
    end

    it "returns nil for empty  word transformations" do
      corrector.stub deletes: []
      corrector.stub transposes: []
      corrector.stub replaces: []
      corrector.stub inserts: []
      expect(corrector.edits1 "oi").to be_nil
    end
  end

  describe "#deletes" do
    it "returns an array with all possible deletions" do
      expect(corrector.deletes "oi").to eq %w(i o)
    end
  end

  describe "#transposes" do
    it "returns an array with all possible transpositions" do
      expect(corrector.transposes "oi").to eq %w(io)
    end
  end

  describe "#replaces" do
    it "returns an array with all possible replacements with a..z" do
      expect(corrector.replaces "oi").to eq %w(
        ai bi ci di ei fi gi hi ii ji ki li mi
        ni oi pi qi ri si ti ui vi wi xi yi zi
        oa ob oc od oe of og oh oi oj ok ol om
        on oo op oq or os ot ou ov ow ox oy oz
      )
    end
  end

  describe "#inserts" do
    it "returns an array with all possible insertions with a..z" do
      expect(corrector.inserts "oi").to eq %w(
        aoi boi coi doi eoi foi goi hoi ioi joi koi loi moi
        noi ooi poi qoi roi soi toi uoi voi woi xoi yoi zoi
        oai obi oci odi oei ofi ogi ohi oii oji oki oli omi
        oni ooi opi oqi ori osi oti oui ovi owi oxi oyi ozi
      )
    end
  end
end

