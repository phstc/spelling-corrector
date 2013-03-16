require "sinatra"
require_relative "../../src/spelling_corrector"

get "/correct/:word" do
  corrector = SpellingCorrector.new
  corrector.correct params[:word]
end

get "/" do
  redirect "https://github.com/phstc/spelling-corrector"
end

