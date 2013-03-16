# http://norvig.com/spell-correct.html
class SpellingCorrector
  ALPHABET = ("a".."z").to_a.join

  def initialize word
    @word   = word
  end

  # convert to downcase and generate an array containing all words sanitized (\w+)
  def words text
    text.downcase.scan(/\w+/)
  end

  # count how many times each word occurs
  def train features
    model = Hash.new 1
    features.each {|f| model[f] += 1 }
    model
  end

  # remove one letter
  def deletes
    (0...length).collect {|i| @word[0...i] + @word[i+1..-1] }
  end


  # swap adjacent letters
  def transposes
    (0...length-1).collect {|i| @word[0...i] + @word[i+1,1] + @word[i,1] + @word[i+2..-1] }
  end

  # change one letter to another
  def replaces
    replacements = []
    length.times {|i| ALPHABET.each_byte {|l| replacements << @word[0...i] + l.chr + @word[i+1..-1] } }
    replacements
  end

  # add a letter
  def inserts
    insertions = []
    length.times {|i| ALPHABET.each_byte {|l| insertions << @word[0...i] + l.chr + @word[i..-1] } }
    insertions
  end

  def length
    @word.length
  end
end

