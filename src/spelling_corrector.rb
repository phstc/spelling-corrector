# http://norvig.com/spell-correct.html
class SpellingCorrector
  ALPHABET = ("a".."z").to_a.join

  def initialize word
    @word   = word
    @length = word.length
  end

  # remove one letter
  def deletes
    (0...@length).collect {|i| @word[0...i] + @word[i+1..-1] }
  end


  # swap adjacent letters
  def transposes
    (0...@length-1).collect {|i| @word[0...i] + @word[i+1,1] + @word[i,1] + @word[i+2..-1] }
  end

  # change one letter to another
  def replaces
    replacements = []
    @length.times {|i| ALPHABET.each_byte {|l| replacements << @word[0...i] + l.chr + @word[i+1..-1] } }
    replacements
  end

  # add a letter
  def inserts
    insertions = []
    @length.times {|i| ALPHABET.each_byte {|l| insertions << @word[0...i] + l.chr + @word[i..-1] } }
    insertions
  end
end

