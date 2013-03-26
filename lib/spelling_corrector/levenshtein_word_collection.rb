class LevenshteinWordCollection
  def nwords
    @nwords ||= untrained_collection_text.collect {|word| word.downcase.gsub "\n", ""}
  end

  private

  # OSX /usr/share/dict/words
  def untrained_collection_text
    File.new(File.expand_path("../../../data/words", __FILE__)).readlines
  end
end

