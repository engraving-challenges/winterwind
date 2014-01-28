# openLilyLib Engraving Challenges

## Challenge #02 - Chopin/Godowsky

### LilyPond development version

This document will be the report of tackling the Chopin/Godowsky challenge
with the stable version of
[MuseScore 1.3](http://musescore.org)
I'm working on a small netbook with no mouse, so I might be slower than being on a big workstation, but that's my problem :)

#### Analysis
- The score seems somewhat complicated, so I think I will have to rely on many manual adjustments and some drawing as well
- I don't think that the nonstandard beaming is supported by MuseScore. First I will create that before the full raw note entry, as first I want to know how I'll do that.
The solution can affect how I typeset the raw notes.
- So first I did the first bar right hand first 3 quarters
- I spent cca. 30 minutes about experimenting with a solution to do the non-standard beaming. I think I will rely on putting in white boxes when everything is ready
as the slope of the beam can change.
- I just realized that they are note quarter notes, but tuplets...
- Anyway, probably I will do some tricks with moving manually 8th notes and 16th notes to have correct beaming, keeping only the beam visible. That will need manually
setting the slopes as well... it won't be a fast process and must be done when the line breaks and every positions are fixed

#### Note entry
- The first deep note was written by just counting the ledger lines -- I didn't know what note is that :)
- The second voice rests had to be made invisible

