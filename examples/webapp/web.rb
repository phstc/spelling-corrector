require "sinatra"
require_relative "../../src/persisted_word_collection"
require_relative "../../src/spelling_corrector"

get "/correct/:word" do
  Mongoid.load! File.expand_path("../config/mongoid.yml", __FILE__)

  collection = PersistedWordCollection.new
  SpellingCorrector.new(collection).correct params[:word]
end

get "/" do
  redirect "https://github.com/phstc/spelling-corrector"
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
