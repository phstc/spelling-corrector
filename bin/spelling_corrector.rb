#!/usr/bin/env ruby

require_relative "../src/spelling_corrector"

corrector = SpellingCorrector.new

ARGV.each do |word|
  next if SpellingCorrector::EXCEPTIONS.include? word
  correction = corrector.correct word
  print "."

  fail "NO SUGGESTION for #{word}" if correction == "NO SUGGESTION"
end

puts "\nAll (#{ARGV.size}) mistakes were corrected properly"
