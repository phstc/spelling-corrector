class PersistedWordCollection
  include Mongoid::Document
  field :word, type: String
  field :rank, type: Integer

  def nwords
    persisted_collection = PersistedWordCollection.all
    if persisted_collection.any?
      persisted_collection_arr = {}
      persisted_collection.each do |persisted|
        persisted_collection_arr[persisted.word] = persisted.rank
      end
      persisted_collection_arr
    else
      load_word_collection
    end
  end

  private

  def load_word_collection
    word_collection = WordCollection.new
    word_collection.nwords.each do |word_arr|
      PersistedWordCollection.create({word: word_arr[0], rank: word_arr[1]})
    end
    word_collection.nwords
  end
end

