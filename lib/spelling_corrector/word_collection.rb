class WordCollection
  attr_reader :nwords

  def nwords
    @nwords ||= train words untrained_collection_text
  end

  # convert to downcase and generate an array containing all words sanitized (\w+)
  def words text
    text.downcase.scan /\w+/
  end

  # count how many times each word occurs
  def train features
    model = Hash.new 1
    features.each {|f| model[f] += 1 }
    model
  end

  private

  # load a big collection of known words (about a million words)
  def untrained_collection_text
    File.new(File.expand_path("../../../data/holmes.txt", __FILE__)).read
  end
end

