\version "2.18.0"


\header {
  % Remove default LilyPond tagline
  tagline = ##f
}
 #(set-global-staff-size 17.6)
\paper {
  #(set-paper-size "letter" )
   indent = 0\cm 
    system-system-spacing #'padding = #5
    
}

global = {
  \key a \minor
  \time 4/4
}

rightOne = \relative c'' {
  \global
  % Music follows here.
  <e, b'>4-\staccato\(^\markup{ \italic"meno" \dynamic {
    f
  }} <e g b>8.-. q16\staccato <b e b'>4-. <c e c'>4-.\accent <b e b'>4^\staccato^\tenuto_\> <g b g'>4-. <b e g b>2-.\<\) %\bar 2
\omit TupletBracket\omit TupletNumber\tuplet 3/2{ \once\override Beam #'positions = #'(6 . 10) \once\override Hairpin #'rotation = #'(7 0 0) \once \override DynamicText #'extra-offset = #'( 0.0 . -2.0 ) g'8[(\(\!^\mf^\<  fis) <a g'>(\once\set fingeringOrientations = #'(left)  <fis'-4>) <a g'>( <c fis>])\)\!}\times 2/3{ \set fingeringOrientations = #'(left) \once\override Hairpin #'rotation = #'(-7 0 0)   <g-1 fis'-5>[\accent(\(^\> <c e>) <g, fis'>( <c e>) <g, fis'>(  <e'-4>)\)\!]} %\bar 3 
\once\override Beam #'positions = #'(6 . 10)  \tuplet 3/2{ \once\override Hairpin #'rotation = #'(7 0 0)  g8[(\(^\<  fis) <a g'>(   fis'-\tweak #'Y-offset #8 -2 -\tweak #'Y-offset #10 -4) <a g'>( <dis fis>]\!)\)}\times 2/3{ \once\override Hairpin #'rotation = #'(-7 0 0)  <g, fis'>^\>[\accent(\( <b e>) <g, fis'>( <b e>) fis^1^5 -\tweak #'X-offset #-5 -5 (  e_4)\)\!]} %\bar 4 
\tuplet 3/2{gis8^1^5 ( fis) s } fis'8.-\tweak #'Y-offset #1.3 \tweak #'X-offset #-3.1 -2 -\tweak #'Y-offset #0 \tweak #'X-offset #-3 -1  \accent fis16 -\tweak #'Y-offset #3 -1\accent \tuplet 3/2{ <fis fis'>4-\tweak #'Y-offset #'0 _\accent b,8\rest}  \once \override NoteColumn.force-hshift = #-1.8 fis8.\accent fis16\accent \tuplet 3/2 {\once\override Hairpin #'rotation = #'(7 0 0)  fis4^\<^2^5^\accent fis'4 b8.\accent <b-2>16\accent} <dis b'>4 \! b,4\rest %bar6
\stemDown  \once \override Staff.OttavaBracket.extra-offset = #'(-2 . 0)
  \once \override Staff.OttavaBracket.shorten-pair = #'(0 . 24.5) \ottava 1 <b' e g b>4-._\ff\( q8.  <\parenthesize b e g b>16-. <b e g b>4-. 
\once \override Script.avoid-slur = #'inside <c e c'>4-.\accent <b e b'>4-.--\< <g b g'>4-. <b e g b>2-.\! \) \ottava 0

}

rightTwo = \relative c'' {
  \global
  % Music follows here.
  s1*2 %\bar 2
\omit TupletNumber\omit TupletBracket  <a, c>4\accent  c'8.-\tweak #'Y-offset #0 -\tweak #'X-offset #-3 -2\accent   \change Staff = "left" \stemUp c16^\accent c4-\tweak #'Y-offset #7.5 -2 -\tweak #'Y-offset #9 -1-\tweak #'Y-offset #11 ^\accent c,8.-\tweak #'Y-offset #4 -1 ^\accent \change Staff = "right" \stemDown c16 -\tweak #'X-offset #0.2 -\tweak #'Y-offset #-5 -2\accent %\bar3
  <a c>4\accent \tuplet 3/2{ d'!8\accent^\( \change Staff = "left" \stemUp c8.^\accent b16^\accent} b4^1^\accent\) \tuplet 3/2 {d,8^2^1^\accent\( \change Staff = "right" \stemDown c8.-2\accent _\< b16-\tweak #'Y-offset #-6 -1 -\tweak #'Y-offset #0 -\tenuto -\tweak #'Y-offset #2 -2 \accent \! }%bar 4
 \tuplet 3/2{ b4\accent\) <ais' ais'>8\(}\tuplet 3/2{ < b b' -\tweak #'Y-offset #-2.2 -\tweak #'X-offset #-3 -5>8 _\< < dis dis'>8 <gis gis'>8\! }\tuplet 3/2{<ais e'>4\) s8} \tuplet 3/2{\once \override NoteColumn.force-hshift = #0.05   e,4 <fis, ais>8} \tuplet 3/2{ ais[( b)]  ais'[( b^\accent)] <gis' gis'>8 <fis fis'>8} b4-\tweak #'Y-offset #-1 \accent s4
}

leftOne = \relative c' {
  \global
  % Music follows here.
  \set Timing.beamExceptions = #'()
\set subdivideBeams = ##t
\set baseMoment = #(ly:make-moment 1/6)
\set beatStructure = #'( 3 3 )
  
\omit TupletBracket\omit TupletNumber\tuplet 3/2{ \change Staff = "right" \stemDown \once \override Beam #'positions = #'( -8.0 . -9.0 ) g8[ \change Staff = "left" \stemUp fis16 \set stemRightBeamCount = #1 b  \set stemLeftBeamCount = #1 f  \once \override Stem.beaming = #(cons (list 1 0) (list 1)) g \once \override Stem.beaming = #(cons (list 0) (list -1 0))  }\tuplet 3/2{ \once \override Staff.SustainPedal.stencil =
  	#(lambda (grob) (grob-interpret-markup grob 
  	(markup #:concat ( "(" #:musicglyph "pedal.Ped"".)"))))} \tuplet 3/2{ \once \override Beam #'positions = #'( 6.0 . 5.0 )   e\sustainOn \set stemRightBeamCount = #1 b' \set stemLeftBeamCount = #1 dis, g d b']}
 \once \override Beam #'positions = #'(4 . 4) \tuplet 3/2{ cis,16[ \sustainOn e c \set stemRightBeamCount = #1 g' \set stemLeftBeamCount = #1 b, \once \override Stem.beaming = #(cons (list 1 0) (list 1)) e \once \override Stem.beaming = #(cons (list 0) (list -1 0))}\tuplet 3/2{ ais,\sustainOn \set stemRightBeamCount = #1 g' \set stemLeftBeamCount = #1 a, c gis e']}%b1
\tuplet 3/2{g,!16\sustainOn[ b fis e' f, \once \override Stem.beaming = #(cons (list 1 0) (list 1)) g \once \override Stem.beaming = #(cons (list 0) (list -1 0)) e\sustainOn b' dis, g d b']}\tuplet 3/2{ cis,16\sustainOn[ e c g' b,^4 \once \override Stem.beaming = #(cons (list 1 0) (list 1)) e^2 \once \override Stem.beaming = #(cons (list 0) (list -1 0)) ais,^5\sustainOn g'^1 b,^5 g'^2 e^3 b'^1]}
\tuplet 3/2{\once\override Beam #'positions = #'(6 . 9) \once\override Hairpin #'rotation = #'(5 -1 0) b16_\<-\tweak #'X-offset #0 -\tweak #'Y-offset #2 -5 -\tweak #'X-offset #0 -\tweak #'Y-offset #3.5 -1[ fis-\tweak #'Y-offset #0 ^4 a-\tweak #'Y-offset #0 ^3 c-\tweak #'Y-offset #2 ^2 b' -\tweak #'Y-offset #4 ^1 \once \override Stem.beaming = #(cons (list 1 0) (list 1)) fis-\tweak #'Y-offset #3  -4 \once \override Stem.beaming = #(cons (list 0) (list -1 0)) \once \override Stem.beaming = #(cons (list 0) (list -1 0)) a-\tweak #'Y-offset #4 ^3 c-\tweak #'Y-offset #0 -2 b'-\tweak #'Y-offset #0 _1 fis -\tweak #'Y-offset #0 _3 a-\tweak #'Y-offset #0 _2 c,]\!}\stemDown  \once\override Beam #'positions = #'(-4 . -6)   \tuplet 3/2{ \once\override Hairpin #'rotation = #'(-2 -1 0)   a'16_\>[\sustainOn e^4 g^3^2_1 c,^5_2 a^1_3 \once \override Stem.beaming = #(cons (list 1 0) (list 1)) e^3_5 \once \override Stem.beaming = #(cons (list 0) (list -1 0))  \once \override Staff.SustainPedal.stencil =
  	#(lambda (grob) (grob-interpret-markup grob 
  	(markup #:concat ( "(" #:musicglyph "pedal.Ped"".)")))) g\sustainOn c,-\tweak #'Y-offset #1  -5 a -\tweak #'Y-offset #0 -1 e-\tweak #'Y-offset #0 ^5 ais -\tweak #'Y-offset #0 -2 g -\tweak #'Y-offset #0 ^3\!]}
\tuplet 3/2{\stemUp b16[ fis a c b' fis a c] \stemDown c'[ fis, a b,]} \once\override Beam #'positions = #'(-4 . -6)\tuplet 3/2{\once\override Hairpin #'rotation = #'(-2 0 0) a'16^2_\>[-\tweak #'Y-offset #-6 \sustainOn e^4 g-\tweak #'Y-offset #5.5 ^3-\tweak #'Y-offset #7.5 ^\tenuto^2_1 b,_2^5 a^1_3 \once \override Stem.beaming = #(cons (list 1 0) (list 1)) e^3_5 \once \override Stem.beaming = #(cons (list 0) (list -1 0)) \once \override Stem.beaming = #(cons (list 0) (list -1 0))  \once \override Staff.SustainPedal.stencil =
  	#(lambda (grob) (grob-interpret-markup grob 
  	(markup #:concat ( "(" #:musicglyph "pedal.Ped"".)")))) g\sustainOn b,-\tweak #'Y-offset #1 ^5 a-\tweak #'Y-offset #0 -1 e-\tweak #'Y-offset #0 -5  g -\tweak #'Y-offset #0 -4 \! b-\tweak #'Y-offset #0 ^2]} %\bar4
\tuplet 3/2{\stemUp \once\override Hairpin #'rotation = #'(-1 0 0)  e16_\<[ b_4-\tweak #'Y-offset #2 ^3 dis_3-\tweak #'Y-offset #2 ^2 fis-\tweak #'Y-offset #-1 _2 -\tweak #'Y-offset #2 ^1 e'-\tweak #'Y-offset #2 _1-\tweak #'Y-offset #5 ^2 \once \override Stem.beaming = #(cons (list 1 0) (list 1)) b-\tweak #'Y-offset #0.6 _5  \once \override Stem.beaming = #(cons (list 0) (list -1 0))\once \override Stem.beaming = #(cons (list 0) (list -1 0)) \once \override Stem.beaming = #(cons (list 0) (list -1 0)) \once \override Stem.beaming = #(cons (list 0) (list -1 0)) dis-\tweak #'Y-offset #1 _3  fis-\tweak #'Y-offset #1 _2 \clef "treble" cis'_1 fis,_5 b_3 bis_2]}\tuplet 3/2{\stemUp  dis16_1_\>_\tweak #'Y-offset #-6 \sustainOn[ ais_3 cis_2 fis,_5 dis_1 \once \override Stem.beaming = #(cons (list 1 0) (list 1))  ais \once \override Stem.beaming = #(cons (list 0) (list -1 0)) cis fis, \clef "bass" dis_1 ais_2 cis_1 <b,! fis'>\!\sustainOn]}%bar5
s1
\omit TupletBracket \tuplet 3/2{<e, e'>8_\marcato\sustainOn \clef "treble" \stemDown fis''''16[ b f \once \override Stem.beaming = #(cons (list 1 0) (list 1)) g \once \override Stem.beaming = #(cons (list 0) (list -1 0)) e b' dis, g d b']}\tuplet 3/2{ cis,[ e c g' b,\once \override Stem.beaming = #(cons (list 1 0) (list 1)) e \once \override Stem.beaming = #(cons (list 0) (list -1 0)) }\tuplet 3/2{ ais, g' a, c gis e']} \tuplet 3/2{ \stemUp g,!16[ b fis e' f, \once \override Stem.beaming = #(cons (list 1 0) (list 1)) g \once \override Stem.beaming = #(cons (list 0) (list -1 0)) \once \override Stem.beaming = #(cons (list 0) (list -1 0)) e b' dis, g d b']}\tuplet 3/2{   cis,16[ e c g' b, \once \override Stem.beaming = #(cons (list 1 0) (list 1)) e \once \override Stem.beaming = #(cons (list 0) (list -1 0))  ais, 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      g' a,^ \> b  aes e' \!
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ]} \clef "bass"
}

leftTwo = \relative c' {
  \global
  % Music follows here.

  
\stemUp  e,,,8_\marcato\sustainOn^\markup \italic"dim." s8 s2. s1 %bar2
\stemDown dis'4\sustainOn  \once \override Staff.SustainPedal.stencil =
  	#(lambda (grob) (grob-interpret-markup grob 
  	(markup #:concat ( "(" #:musicglyph "pedal.Ped"".)"))))  dis'4-5-\tweak #'Y-offset #-6 \sustainOn  s2  \once\override Hairpin #'rotation = #'(7 -1 0) dis,4\sustainOn_\<  \once \override Staff.SustainPedal.stencil =
  	#(lambda (grob) (grob-interpret-markup grob 
  	(markup #:concat ( "(" #:musicglyph "pedal.Ped"".)")))) dis'4-\tweak #'Y-offset #-4 \sustainOn\! s2  %bar 4
fis,4\sustainOn s2.    <<{s4 \tuplet 3/2 {\stemDown\clef "treble" dis''8_\( cisis8 dis8}  b4\sustainOn\) s4}\\{s4 \once\override TupletNumber #'stencil = ##f  \times 2/3{ s8. \once\override Beam #'positions = #'(-1.45 . -1.45) \once \override Beam #'beam-thickness = #0.32   b'8 b16^\accent-\tweak #'Y-offset #1 -2 } s4}\\{ \set Timing.beamExceptions = #'()
\set subdivideBeams = ##t
\set baseMoment = #(ly:make-moment 1/6)
\set beatStructure = #'( 3 3 ) \once\override Beam #'positions = #'(6 . 8)  \omit TupletNumber \tuplet 3/2{\stemUp  e,,16_1[ b_5 dis_3_4 fis_2 e'-\tweak #'Y-offset #0  _1 \once \override Stem.beaming = #(cons (list 1 0) (list 1)) b-\tweak #'Y-offset #0 _5 \once \override Stem.beaming = #(cons (list 0) (list -1 0)) \clef "treble" \once \override Staff.SustainPedal.stencil =
  	#(lambda (grob) (grob-interpret-markup grob 
 	(markup #:concat ( "(" #:musicglyph "pedal.Ped"".)")))) dis16-\tweak #'Y-offset #0 -3-\tweak #'Y-offset #2 -4\sustainOn fis -\tweak #'Y-offset #0 -2 e' b-\tweak #'Y-offset #2 -2 dis \change Staff = "right" \stemDown fis16-\tweak #'X-offset #-1 -\tweak #'Y-offset #1 -1]} \change Staff = "left" \stemUp <fis, b>4\accent \clef "bass" <b,,, b'>8.^\< q16\! 
\omit TupletBracket}>> s8 s2.  s2. s8  \change Staff = "right"  \omit TupletNumber \omit TupletBracket \tuplet 3/2 {s8   \once \override TextScript #'avoid-slur = #'inside
\once \override Hairpin #'outside-staff-priority = ##f \override Stem #'cross-staff = ##t  \tiny \override Stem #'length = #18   a'''!4*1/4^\markup\italic"mano destra a piacere"    b  aes \override Stem #'length = #21 e'}
}

\score {
  \new PianoStaff  \with {\override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 15))}  <<
    \new Staff = "right" \with {
      midiInstrument = "acoustic grand"
    } << \rightOne \\ \rightTwo >>
    \new Staff = "left" \with {
      midiInstrument = "acoustic grand"
    } { \clef bass << \leftOne \\ \leftTwo >> }
  >>
  \layout {
\context {
\Score \override SpacingSpanner #'common-shortest-duration = #(ly:make-moment 1 8) 
}

}
 
}
