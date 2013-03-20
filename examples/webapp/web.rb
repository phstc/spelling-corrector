require "sinatra"
require "mongoid"
require_relative "../../src/persisted_spelling_corrector"

Mongoid.load! File.expand_path("../config/mongoid.yml", __FILE__), ENV["RACK_ENV"]

get "/correct/:word" do
  PersistedSpellingCorrector.new.correct params[:word]
end

get "/" do
  redirect "https://github.com/phstc/spelling-corrector"
end

