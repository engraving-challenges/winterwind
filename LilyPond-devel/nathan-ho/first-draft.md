# First draft #

I cobbled together this first draft in about two hours. It returns several warnings, probably has several mistakes, and I haven't yet implemented the fingerings. All the voicing is complete, however. The most obvious error in the result is that the third line runs off the page! LilyPond's spacing engine simply wasn't able to cope with two measures per system. Another issue is the yucky spacing of the sixteenth notes due to LilyPond compressing them together and leaving to room for accidentals. These problems will need to be fixed in adjustment.

I made a lot of adjustments to the engraving while entering it, because I didn't read the instructions until halfway through, and I am a horrible perfectionist when it comes to music notation. After realizing my errors, I backtracked and restricted the adjustments to the following:

- voice assignment
- stem/slur/script/dynamic directions
- manual beaming
- line breaks
- indent, time signature, bar numbers

The biggest change was the cross-staff stems in the final bar. LilyPond simply does not support joining two notes of opposing stem directions, but luckily I had written a hackish script for implementing them a few months prior (I was bored and decided to try a George Crumb score). I hope it is not considered too serious a tweak. 

There are many minor issues, such as the __dim.__ in bar 1 colliding with the beam, the ottava bracket grazing too close to the slur in the last line, and the melody in bar 3 interrupting a beam of sixteenth notes. But overall, LilyPond handled the piece impressively well for its difficulty level (especially the third and fourth bars), and I didn't encounter any major roadblocks except for my own lack of self-control.
