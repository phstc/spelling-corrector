require "sinatra"
require_relative "../../lib/persited_spelling_corrector"

Mongoid.load! File.expand_path("../config/mongoid.yml", __FILE__), ENV["RACK_ENV"] || "development"

get "/correct/:word" do
  PersistedSpellingCorrector.new.correct params[:word]
end

get "/" do
  redirect "https://github.com/phstc/spelling-corrector"
end


