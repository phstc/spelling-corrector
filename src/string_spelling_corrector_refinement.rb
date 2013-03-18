require_relative "spelling_corrector"

# using StringSpellingCorrectorRefinement
# "cen".correct => "can"

module StringSpellingCorrectorRefinement
  refine String do
    def correct
      @corrector ||= SpellingCorrector.new
      @corrector.correct self
    end
  end
end

