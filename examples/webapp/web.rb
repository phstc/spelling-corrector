require "sinatra"
require "mongoid"
require_relative "../../src/spelling_corrector_collection"
require_relative "../../src/spelling_corrector"

get "/correct/:word" do
  Mongoid.load! File.expand_path("../config/mongoid.yml", __FILE__)

  collection = PersistedWordCollection.new
  SpellingCorrector.new(collection).correct params[:word]
end

get "/" do
  redirect "https://github.com/phstc/spelling-corrector"
end


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
    collection = word_collection.nwords.map do |word_arr|
      {word: word_arr[0], rank: word_arr[1]}
    end
    PersistedWordCollection.create(collection)
    word_collection.nwords
  end

  def word_collection
    @corrector_collection ||= SpellingCorrectorCollection.new
  end
end

# class PersistedWordCorrection
# include Mongoid::Document
# field :word, type: String
# field :correction, type: String

# def initialize collection=nil
# @collection = collection
# end

# def correct word
# end

# end
