#!/usr/bin/env ruby

require_relative "../src/spelling_corrector"

corrector = SpellingCorrector.new

correctly_spelled =  %w(sheeeeep peepple sheeple inSIDE jjoobbb weke CUNsperrICY)

all_words = correctly_spelled.map { |word| corrector.edits1(word) } + correctly_spelled
all_words.flatten!

all_words.each do |word|
  puts word + "\n"
end

