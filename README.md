# Spelling Corrector

It's a Ruby implementation of [Norvig Spelling Corrector](http://norvig.com/spell-correct.html) plus [Levenshtein distance](http://en.wikipedia.org/wiki/Levenshtein_distance) fallback.

If Norvig algorithm doesn't find the correction, this implementation will look for the first occurrence (distance < 7) of a similar word using Levenshtein distance.

```ruby
known([word]) || known(edits1(word)) || known_edits2(word) || levenshtein(word) || ["NO SUGGESTION"]
```

Levenshtein costs: ins=2, del=2 and sub=1.

## The Algorithm

Firstly, I recommend to read the [Norvig explanation](http://norvig.com/spell-correct.html) and [Levenshtein distance](http://en.wikipedia.org/wiki/Levenshtein_distance) then have a look at the tests (specs directory), they show how each method work, it helps the understading of the algorithm.

Most of the `SpellingCorrector` methods, should be private, I left them as public only to document (explain) them with tests.

## How to use it

```ruby
require "lib/spelling_corrector"

corrector = SpellingCorrector.new
corrector.correct "cen" => "can"

corrector.correct "unknownword" => "NO SUGGESTION"
```

### Persisted Spelling Corrector

The `PersistedSpellingCorrector` and `PersistedWordCollection` are implementions using MongoDB (encapsulating the non-persisted implementations) to persisted the correction and trained word collection.


## Examples

In the `examples` directory, there are two examples, one using refinements and another with [Sinatra](http://www.sinatrarb.com/) to expose Spelling Corrector as an API.

### Refinements

If you are using Ruby 2.0.0 we can use refine your string classes using the Spelling Corrector.

```ruby
# examples/refinement_spelling_corrector.rb

using StringSpellingCorrectorRefinement

puts "cen".correct
```

### webapp

The webapp example is deployed at Heroku, you can easily test it via `curl` or directly in the browser (shame on you).

```bash
curl spelling-corrector.herokuapp.com/correct/cen
=> can
```

Since it uses PersistedSpellingCorrector, to run it locally, you will need a MongoDB connection.

## License
This code is licensed under:

MIT License GPL
