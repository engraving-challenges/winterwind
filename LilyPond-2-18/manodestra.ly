\version "2.18.0"
upline =
#(let ((m (make-articulation "stopped")))
   (set! (ly:music-property m 'tweaks)
         (acons 'font-size 7
                (acons 'stencil (lambda (grob)
                                  (grob-interpret-markup
                                   grob
                                   (make-draw-line-markup '(0 . 15))))
                       (ly:music-property m 'tweaks))))
   m)
\header {
  % Remove default LilyPond tagline
  tagline = ##f
}

\paper {
  #(set-paper-size "letter" 'landscape)
}

global = {
  \key a \minor
  \time 4/4
}

right = \relative c'' {
  \global 
  % Music follows here.
 << { \ottava 1 <b' e g b>4-._\ff\( q8.  <\parenthesize b e g b>16-. <b e g b>4-. 
\once \override Script.avoid-slur = #'inside <c e c'>4-.\accent <b e b'>4-.--\< <g b g'>4-. <b e g b>2*1/2-.\! \) \ottava 0
    }\\{ s1 s2. \omit TupletBracket
\tuplet 3/2{ 
s8 
  \override TextScript #'outside-staff-priority = #'() \override TextScript #'bounding = #'() \once\override TextScript #'extra-offset = #'(0.1 . -4)\override Stem #'cross-staff = ##t \tiny \override Stem #'length = #19 a,,4*1/4   b aes  e'}}>>
}
   
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      


left = \relative c' {
  \global
  % Music follows here.
   \omit TupletBracket \tuplet 3/2{<e,,, e'>8_\marcato\sustainOn \clef "treble" \stemDown fis''''16[ b f \once \override Stem.beaming = #(cons (list 1 0) (list 1)) g \once \override Stem.beaming = #(cons (list 0) (list -1 0)) e b' dis, g d b']}\tuplet 3/2{ cis,[ e c g' b,\once \override Stem.beaming = #(cons (list 1 0) (list 1)) e \once \override Stem.beaming = #(cons (list 0) (list -1 0)) }\tuplet 3/2{ ais, g' a, c gis e']} \tuplet 3/2{ \stemUp g,!16[ b fis e' f, \once \override Stem.beaming = #(cons (list 1 0) (list 1)) g \once \override Stem.beaming = #(cons (list 0) (list -1 0)) \once \override Stem.beaming = #(cons (list 0) (list -1 0)) e b' dis, g d b']}\omit TupletNumber
\tuplet 3/2{\override  TextScript #'outside-staff-padding = #-3 \override TextScript #'outside-staff-priority = #'() \override TextScript #'bounding = #'()   cis,16[ e c g' b, \once \override Stem.beaming = #(cons (list 1 0) (list 1)) e \once \override Stem.beaming = #(cons (list 0) (list -1 0))  ais, 
  g' a,^\< b \once\override TextScript #'extra-offset = #'(0 . 4) aes e']\!
 } 
  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
}

\score {
  \new PianoStaff \with {
    instrumentName = "Piano"
  } <<
    \new Staff = "right" \with {
      midiInstrument = "acoustic grand"
    } \right
    \new Staff = "left" \with {
      midiInstrument = "acoustic grand"
    } { \clef bass \left }
  >>
 \layout {
 
}
  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 100 4)
    }
  }
}
