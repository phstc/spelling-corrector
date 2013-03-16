require "sinatra"
require_relative "../../src/spelling_corrector"

get "/correct/:word" do
  corrector = SpellingCorrector.new
  corrector.correct params[:word]
end

