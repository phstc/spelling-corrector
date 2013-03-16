# encoding: utf-8

require "spec_helper"

describe "SpellingCorrector" do
  before do
    SpellingCorrector.any_instance.stub nwords: File.new(File.expand_path("../fixtures/holmes.txt", __FILE__)).read
  end

  subject(:corrector) { SpellingCorrector.new "oi" }

  describe "#words" do
    it "converts to downcase and removes any non-word character" do
      expect(corrector.words "OI Óí PaBlO").to eq %w(oi pablo)
    end
  end

  describe "#know" do
    it do
      expect(corrector.known %w(pablo)).to eq []
    end
  end

  describe "#train" do
    it "counts how many times each word occurs" do
      expect(corrector.train(%w(oi oi pablo))).to eq ({"oi" => 3, "pablo" => 2})
    end
  end

  describe "#deletes" do
    it "returns an array with all possible deletions" do
      expect(corrector.deletes).to eq %w(i o)
    end
  end

  describe "#transposes" do
    it "returns an array with all possible transpositions" do
      expect(corrector.transposes).to eq %w(io)
    end
  end

  describe "#replaces" do
    it "returns an array with all possible replacements with a..z" do
      expect(corrector.replaces).to eq %w(
        ai bi ci di ei fi gi hi ii ji ki li mi
        ni oi pi qi ri si ti ui vi wi xi yi zi
        oa ob oc od oe of og oh oi oj ok ol om
        on oo op oq or os ot ou ov ow ox oy oz
      )
    end
  end

  describe "#inserts" do
    it "returns an array with all possible insertions with a..z" do
      expect(corrector.inserts).to eq %w(
        aoi boi coi doi eoi foi goi hoi ioi joi koi loi moi
        noi ooi poi qoi roi soi toi uoi voi woi xoi yoi zoi
        oai obi oci odi oei ofi ogi ohi oii oji oki oli omi
        oni ooi opi oqi ori osi oti oui ovi owi oxi oyi ozi
      )
    end
  end
end

