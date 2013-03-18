# Spelling Corrector

It's a Ruby implementation of [Norvig Spelling Corrector](http://norvig.com/spell-correct.html).

This implementation is a shameless copy of Norvig Python version in Ruby, with minor changes in the sintax and personal preferences.

## The Algorithm

Firstly, I recommend to read the [Norvig explanation](http://norvig.com/spell-correct.html) then have a look at `spec/spelling_corrector_spec.rb`, the tests show how each method work, it helps a lot the understading of the algorithm.

Most of the `SpellingCorrector` methods, should be private, I left them as public only to document (explain) them with tests.


## How to use it

```ruby
require "spelling_corrector"

corrector = SpellingCorrector.new
corrector.correct "cen" => "can"

corrector.correct "unknownword" => "NO SUGGESTION"
```

### Refinements

If you are using Ruby 2.0.0 we can use refine your string classes.

```ruby
require "string_spelling_corrector_refinement"
using StringSpellingCorrectorRefinement
"cen".correct => "can"
```

## Examples

In the `examples` directory, there are two examples, one using refinements and another using [Sinatra](http://www.sinatrarb.com/) to expose Spelling Corrector as an API.

The API is deployed at Heroku, you can easily test it via `curl` or directly in the browser (shame on you).

```bash
curl spelling-corrector.herokuapp.com/correct/cen
=> can
```

## SpellingCorrectorCollection

I separated the concern (SRP) of correcting words in the `SpellingCorrector` and the reading and training the words collection in the `SpellingCorrectorCollection`.

You can easily substitute the word collection when instantiate a new SpellingCorrector.

```ruby
SpellingCorrector.new my_word_collection

# The default word collection is SpellingCorrectorCollection
# class SpellingCorrector
#   def initialize collection=nil
#     @collection ||= SpellingCorrectorCollection.new
```

A NoSQL words collection could be a good option to avoid reading a big file and training the words all times.

## License
This code is licensed under:

MIT License GPL
