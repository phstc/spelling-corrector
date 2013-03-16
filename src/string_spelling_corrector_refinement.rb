if RUBY_VERSION.to_i == 2

  require_relative "spelling_corrector"

  module StringSpellingCorrectorRefinement
    refine String do
      def correct
        @corrector ||= SpellingCorrector.new
        @corrector.correct self
      end
    end
  end

  # Example
  # using StringSpellingCorrectorRefinement
  # "cen".correct => "can"
end

