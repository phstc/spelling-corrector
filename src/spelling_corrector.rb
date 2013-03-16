# http://norvig.com/spell-correct.html
class SpellingCorrector
  ALPHABET = ("a".."z").to_a.join

  def initialize
    @nwords = train words(words_collection)
  end

  def correct word
    (known([word]) || known(edits1(word)) || known_edits2(word) || [word]).max {|a,b| @nwords[a] <=> @nwords[b] }
  end

  # convert to downcase and generate an array containing all words sanitized (\w+)
  def words text
    text.downcase.scan(/\w+/)
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

  # count how many times each word occurs
  def train features
    model = Hash.new 1
    features.each {|f| model[f] += 1 }
    model
  end

  # remove one letter
  def deletes word
    (0...word.length).collect {|i| word[0...i] + word[i+1..-1] }
  end


  # swap adjacent letters
  def transposes word
    (0...word.length-1).collect {|i| word[0...i] + word[i+1,1] + word[i,1] + word[i+2..-1] }
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

  private

  # load a big collection of known words (about a million words)
  def words_collection
    @words_collection ||= File.new(File.expand_path("../../holmes.txt", __FILE__)).read
  end
end

