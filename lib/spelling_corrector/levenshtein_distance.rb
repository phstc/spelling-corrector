# http://www.informit.com/articles/article.aspx?p=683059&seqNum=36
class Levenshtein
  def self.distance(word, other, ins=2, del=2, sub=1)
    # ins, del, sub are weighted costs
    return nil if word.nil?
    return nil if other.nil?
    dm = []        # distance matrix

    # Initialize first row values
    dm[0] = (0..word.length).collect { |i| i * ins }
    fill = [0] * (word.length - 1)

    # Initialize first column values
    for i in 1..other.length
      dm[i] = [i * del, fill.flatten]
    end

    # populate matrix
    for i in 1..other.length
      for j in 1..word.length
        # critical comparison
        dm[i][j] = [
          dm[i-1][j-1] +
          (word[j-1] == other[i-1] ? 0 : sub),
          dm[i][j-1] + ins,
          dm[i-1][j] + del
        ].min
      end
    end

    # The last value in matrix is the
    # Levenshtein distance between the strings
    dm[other.length][word.length]
  end
end

