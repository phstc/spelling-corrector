#!/usr/bin/env ruby

require_relative "../src/spelling_corrector"

corrector = SpellingCorrector.new

ARGV.each do |word|
  correction = corrector.correct word

  fail "NO SUGGESTION for #{word}" if correction == "NO SUGGESTION"
end

puts "SUCCESS"
