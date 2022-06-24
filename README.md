## Soccer Challenge - Scott Russell

This is a command-line application that reads a listing of game
results for a soccer league as a stream and returns the top teams at
the end of each matchday.

To run program:

With an input filename:

```bash
soccer-challenge.rb <filename>
```

With pipe via stdin:

```bash
cat sample-file-input | soccer-challenge.rb
```

To test output:

```bash
./soccer-challenge.rb sample-input.txt |diff expected-output.txt -
```

To run tests:

```bash
ruby test/main.rb
```

## Design

Assuming the league is stable and sensible (does not change teams during a matchday, does not have two identically named teams) allowed me to detect a new day when I see the same team a second time.

This was by and large the only real decision that was made in the app, although I still feel like I might have missed something there.

Otherwise, it was a very straightforward walk-the-stream solution. My initial swing was procedural and inline. I then refactored it into classes with different responsibilities, probably to a larger resolution than necessary, but it's a technical example, not a production app!

Testing was applied follow-on, not in any test-first design capacity. Probably overtested, just to bulk up for the sake of the example. I did not do dependency injection, complex doubling or abstract the report generation just to test one more scenario - any of those steps would have increased the complexity where the testing was more complex than the report mechanism under test, and I was requested to keep the exercise under 3 hours.

I hope you really do push a few terabytes through this, I'd like to hear how it works! :)

## Issues

"Alphabetical order" has a lot of assumptions in it, and I leaned heavily into those assumptions.

I guessed the input format will not change, even though you worried me by mentioning specific delimiters. I chose to interpret that phrase as "explicit marker" - possibly to my own detriment.

Assuming the league was stable and sane, and that the format would be regex-alike till infinity seemed like sensible assumptions, but they were assumptions. If those assumptions prove to be wrong, I think the program will still behave as expected (by me), but the output will become quirky to interpret.

If the app was truly run forever, resulting in a league with millions of days of entries in it, this will blow up without much fanfare or explanation. I will be cold and gone in 2 thousand years, so that can be someone else's problem, if people still score soccer games in the 4050s! :)

The naive solution to solving that challenge would be external storage in a database for matchdays, with purging systems, which I did not implement here.

The tests are mostly for show, the code is pretty simple, and I did not venture into very much integrations testing as there isn't much integration in the code.
