require_relative "spelling_corrector_collection"

# http://norvig.com/spell-correct.html
class SpellingCorrector
  ALPHABET = ("a".."z").to_a.join

  def initialize collection=nil
    @collection ||= SpellingCorrectorCollection.new
    @nwords = @collection.nwords
  end

  def correct word
    word = word.downcase.squeeze
    (known([word]) || known(edits1(word)) || known_edits2(word) || ["NO SUGGESTION"]).max {|a,b| @nwords[a] <=> @nwords[b] }
  end

  def edits1 word
    result = deletes(word) + transposes(word) + replaces(word) + inserts(word)
    result.empty? ? nil : result
  end

  def known words
    result = words.select {|w| @nwords.has_key?(w) }
    result.empty? ? nil : result
  end

  def known_edits2 word
    result = []
    edits1(word).each {|e1| edits1(e1).each {|e2| result << e2 if @nwords.has_key?(e2) }}
    result.empty? ? nil : result
  end

  # remove one letter
  def deletes word
    (0...word.length).map {|i| word[0...i] + word[i+1..-1] }
  end


  # swap adjacent letters
  def transposes word
    (0...word.length-1).map {|i| word[0...i] + word[i+1,1] + word[i,1] + word[i+2..-1] }
  end

  # change one letter to another
  def replaces word
    replacements = []
    word.length.times {|i| ALPHABET.each_byte {|l| replacements << word[0...i] + l.chr + word[i+1..-1] } }
    replacements
  end

  # add a letter
  def inserts word
    insertions = []
    word.length.times {|i| ALPHABET.each_byte {|l| insertions << word[0...i] + l.chr + word[i..-1] } }
    insertions
  end

end

