require "mongoid"
require_relative "spelling_corrector"
require_relative "persisted_word_collection"

class PersistedSpellingCorrector
  include Mongoid::Document
  field :word, type: String
  field :correction, type: String

  def correct word
    persisted_word = PersistedSpellingCorrector.where(word: word).first
    if persisted_word
      correction = persisted_word.correction
    else
      correction = corrector.correct word
      PersistedSpellingCorrector.create({word: word, correction: correction})
    end
    correction
  end

  def corrector
    @corrector ||= SpellingCorrector.new PersistedWordCollection.new
  end
end

