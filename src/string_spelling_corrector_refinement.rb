require_relative "spelling_corrector"

module StringSpellingCorrectorRefinement
  refine String do
    def correct
      @corrector ||= SpellingCorrector.new
      @corrector.correct self
    end
  end
end

