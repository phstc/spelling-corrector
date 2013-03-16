require "spec_helper"
require_relative "../spelling_corrector"


describe "SpellingCorrector" do
  subject(:corrector) { SpellingCorrector.new "oi" }

  describe "#deletes" do
    it "returns an array with all possible deletions" do
      expect(corrector.deletes).to eq %w(i o)
    end
  end

  describe "#transposes" do
    it "returns an array with all possible transpositions" do
      expect(corrector.transposes).to eq %W(io)
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

