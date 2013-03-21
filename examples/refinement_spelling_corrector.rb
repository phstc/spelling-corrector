require_relative "../lib/spelling_corrector"

module StringSpellingCorrectorRefinement
  refine String do
    def correct
      @corrector ||= SpellingCorrector.new
      @corrector.correct self
    end
  end
end

using StringSpellingCorrectorRefinement

puts "cen".correct

