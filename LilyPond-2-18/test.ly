\version "2.18.0"

\header {
  % Remove default LilyPond tagline
  tagline = ##f
}
 #(set-global-staff-size 36)
\paper {
  #(set-paper-size "letter" 'landscape)
}

global = {
  \key a \minor
  \time 4/4
}

rightOne = \relative c' {
  \global
  % Music follows here.
\tuplet 3/2{ fis4 -\tweak #'X-offset #-2 -\tweak #'Y-offset #-5 ^2 -\tweak #'X-offset #-2 -\tweak #'Y-offset #-3 ^5^\accent fis'4 b8.\accent <b-2>16\accent} <dis b'>4 b,4\rest
}

rightTwo = \relative c' {
  \global
  % Music follows here.
  \tuplet 3/2{ ais8[( b)]  ais'[( b\accent)] <gis' gis'>8 <fis fis'>8} b4\accent s4
}

leftOne = \relative c' {
  \global
  % Music follows here.
  <<{s4 \tuplet 3/2 {\stemDown\clef "treble" dis8\( cisis8 dis8}  b4\sustainOn\) s4}\\{s4 \times 2/3{ s8. \once\override Beam #'positions = #'(-1.4 . -1.4)  b'8 b16^\accent } s4}\\{ \tuplet 3/2{\stemUp  e,,16_1[ b_5 dis_3_4 fis_2 e'_1 b_5 \clef "treble" \once \override Staff.SustainPedal.stencil =
  	#(lambda (grob) (grob-interpret-markup grob 
 	(markup #:concat ( "(" #:musicglyph "pedal.Ped"".)")))) dis16^4 ^3\sustainOn fis^2 e' b dis  <fis-1>16]} \change Staff = "left" \stemUp <fis, b>4\accent \clef "bass" <b,,, b'>8.\< q16\! 
\omit TupletBracket}>>
}

leftTwo = \relative c {
  \global
  % Music follows here.
 s1
}

\score {
  \new PianoStaff \with {
    instrumentName = "Piano"
  } <<
    \new Staff = "right" \with {
      midiInstrument = "acoustic grand"
    } << \rightOne \\ \rightTwo >>
    \new Staff = "left" \with {
      midiInstrument = "acoustic grand"
    } { \clef bass << \leftOne \\ \leftTwo >> }
  >>
  \layout { }
  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 100 4)
    }
  }
}
