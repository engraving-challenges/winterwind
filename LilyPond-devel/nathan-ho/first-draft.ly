\version "2.19.0"

\pointAndClickOff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Engraver allowing \crossStaff with opposite stem directions
% From music-functions.scm, slight modification

#(define (close-enough? x y)
  "Values are close enough to ignore the difference"
  ;; Greatly reduced precision from the original
  (< (abs (- x y)) 0.1))

#(define (extent-combine extents)
  "Combine a list of extents"
  (if (pair? (cdr extents))
      (interval-union (car extents) (extent-combine (cdr extents)))
      (car extents)))

#(define ((stem-connectable? ref root) stem)
  "Check if the stem is connectable to the root"
  ;; The direction requirement has been removed
  ;; The root is always connectable to itself
  (or (eq? root stem)
       ;; Horizontal positions of the stems must be almost the same
       (close-enough? (car (ly:grob-extent root ref X))
                      (car (ly:grob-extent stem ref X)))))

#(define (stem-span-stencil span)
  "Connect stems if we have at least one stem connectable to the root"
  (let* ((system (ly:grob-system span))
         (root (ly:grob-parent span X))
         (stems (filter (stem-connectable? system root)
                        (ly:grob-object span 'stems))))
    (if (<= 2 (length stems))
        (let* ((yextents (map (lambda (st)
                                (ly:grob-extent st system Y)) stems))
               (yextent (extent-combine yextents))
               (layout (ly:grob-layout root))
               (blot (ly:output-def-lookup layout 'blot-diameter)))
          ;; Hide spanned stems
          (map (lambda (st)
                 (set! (ly:grob-property st 'stencil) #f))
               stems)
          ;; Draw a nice looking stem with rounded corners
          (ly:round-filled-box (ly:grob-extent root root X) yextent blot))
        ;; Nothing to connect, don't draw the span
        #f)))

#(define ((make-stem-span! stems trans) root)
  "Create a stem span as a child of the cross-staff stem (the root)"
  (let ((span (ly:engraver-make-grob trans 'Stem '())))
    (ly:grob-set-parent! span X root)
    (set! (ly:grob-object span 'stems) stems)
    ;; Suppress positioning, the stem code is confused by this weird stem
    (set! (ly:grob-property span 'X-offset) 0)
    (set! (ly:grob-property span 'stencil) stem-span-stencil)))

#(define-public (cross-staff-connect stem)
  "Set cross-staff property of the stem to this function to connect it to
other stems automatically"
  #t)

#(define (stem-is-root? stem)
  "Check if automatic connecting of the stem was requested.  Stems connected
to cross-staff beams are cross-staff, but they should not be connected to
other stems just because of that."
  (eq? cross-staff-connect (ly:grob-property-data stem 'cross-staff)))

#(define (make-stem-spans! ctx stems trans)
  "Create stem spans for cross-staff stems"
  ;; Cannot do extensive checks here, just make sure there are at least
  ;; two stems at this musical moment
  (if (<= 2 (length stems))
      (let ((roots (filter stem-is-root? stems)))
        (map (make-stem-span! stems trans) roots))))

#(define-public (Kneed_span_stem_engraver ctx)
  "Connect cross-staff stems to the stems above in the system"
  (let ((stems '()))
    (make-engraver
     ;; Record all stems for the given moment
     (acknowledgers
      ((stem-interface trans grob source)
       (set! stems (cons grob stems))))
     ;; Process stems and reset the stem list to empty
     ((process-acknowledged trans)
      (make-stem-spans! ctx stems trans)
      (set! stems '())))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

chu = \change Staff = "up"
chd = \change Staff = "down"

global = {
  \tempo "Allegro con brio." 2=58-66
  \accidentalStyle modern
  \override Staff.TimeSignature.stencil =
    #(lambda (grob)
       (grob-interpret-markup
         grob
         #{
           \markup {
             \override #'(baseline-skip . 0) \number \vcenter \center-column {
               "12" "8" \vspace #1/3 \musicglyph #"timesig.C44" \vspace #1/3
             }
           }
         #}))
  \time 4/4
}

conductor = {
  \repeat unfold 4 { s1*2 \break }
}

voiceA = \transpose c c' {
  \chu
  \override Script.direction = #UP
  \dynamicUp
  \voiceOne
  | <e b>4-.(^\markup { \italic "meno" \dynamic "f" } <e g b>8.-. q16-. <b, e b>4-. <c e c'>4-.->
  | <b, e b>4-_ <g, b, g>4-. <b, e g b>2-.)
  \tuplet 6/4 2 {
    | g8[(\(^\mf\< fis) <a g'>( fis')-4 <a' g''>( <c'' fis''>])\)\! <g'-5 fis''-1>[(\(->\> <c'' e''>) <g fis'>( <c' e'>) <g, fis>( e])\)-4
    | g[(\(\< fis) <a g'>( fis')-4 <a' g''>( <dis'' fis''>])\)\! <g' fis''>[(\(->\> <b' e''>) <g fis'>( <b e'>) fis(-5 e]-4)\)\!
  }
  | \tuplet 3/2 { gis8(-5 fis8) s8 } fis'8.-> fis'16->-1 <fis' fis''>4_> fis8.-> fis16->
  | \tuplet 3/2 { fis4->-5\< fis'4 b'8.-> b'16->-2 } <dis'' b''>4 r4\!
  \ottava #1
  \oneVoice
  \transpose c c'' {
    | <b, e g b>4-.( q8.-. <\parenthesize b, e g b>16-. <b, e g b>4-. <c e c'>4-.->
    | <b, e b>4-_ <g, b, g>4-. << <b, e g b>2-.) { s4 \ottava #0 s4 } >>
  }
}

voiceB = \transpose c c' {
  \chu
  | s1*2
  | \voiceTwo <c a,>4-> c'8.->-2 \chd \voiceOne c'16-> c'4->-1 c8.->-1 \chu \voiceTwo c16->-2
  | <c a,>4-> \tuplet 3/2 { \once \slurUp d'8->(-2 \chd \voiceOne c'8.-> b16-> } b4)-1 \tuplet 3/2 { \once \slurDown d8->(-1 \chu \voiceTwo c8.->-2 b,16->-2 }
  \tuplet 3/2 4 {
    | b,4)-1 <ais ais'>8( <b-1 b'-5>8\< <dis' dis''>8 <gis' gis''>8\! <ais' e''>4) r8 e4 <fis, ais,>8
    | ais,8[(-2 b,])-1 ais[( b]) <gis' gis''>[ <fis' fis''>]
  }
  s2
  | s1
  | s2
  \stemDown
  \autoBeamOff
  \omit Flag
  \override NoteColumn.X-offset = #(lambda (grob) (+ (ly:note-head::stem-x-shift grob) 1.2))
  <>^\markup \italic "mano destra a piacere"
  \tuplet 3/2 { s2 \tiny a,16 b, as, e }
}

bLO = \once \override Stem.beaming = #(cons (list 0 1) (list 0))
bRO = \once \override Stem.beaming = #(cons (list 0) (list 0 1))
bLI = \once \override Stem.beaming = #(cons (list 0 -1) (list 0))
bRI = \once \override Stem.beaming = #(cons (list 0) (list 0 -1))

voiceC = {
  \chu
  \tuplet 6/4 2 {
    | \stemDown g8[ \chd \stemUp fis16 \bLO b \bRO f \bLI g \bRI e \bLO b \bRO dis g d b] \stemNeutral cis[ e c \bLO g \bRO b, \bLI e \bRI ais, \bLO g \bRO a, c gis, e]
    | g,[ b, fis, \bLO e \bRO f, \bLI g, \bRI e, \bLO b, \bRO dis, g, d, b,] cis,[ e, c, \bLO g, \bRO b,,-4 \bLI e,-2 \bRI ais,,-5 \bLO g,-1 \bRO b,,-5 g,-2 e,-3 b,]-1
    | \voiceOne b,[-1\< fis,-4 a,-3 \bLO c-2 \bRO b-1 \bLI fis-4 \bRI a-3 \bLO c'-2 \bRO b'-1 fis'-3 a'-2 c']\! \voiceTwo a'[-2\> e'-4 g'-2 \bLO c'-5 \bRO a-1 \bLI e-3 \bRI g-2 \bLO c-5 \bRO a,-1 e,-5 ais,-2 g,]-3
    | \voiceOne b,[\< fis, a, \bLO c \bRO b fis a c']\! \voiceTwo c''[-1 fis'-3 a'-2 b] a'[-2\> e'-4 g'-2 \bLO b-5 \bRO a-1 \bLI e-3 \bRI g-2 \bLO b,-5 \bRO a,-1 e,-5 g,-4 b,]-2
    | \voiceOne e[\< b,-3 dis-2 fis-1 \bLO e'-1 \bRO b-5 \bLI dis'-3 \bRI fis'-2 \clef treble \bLO cis''-1 \bRO fis'-5 b'-3 bis']-2\! dis''[-1\> ais'-3 cis''-2 \bLO fis'-5 \bRO dis'-1 \bLI ais \bRI cis' \bLO fis \clef bass \bRO dis-1 ais,-2 cis-1 <b,, fis,>]\!
    | e[-1 b,-5 dis-3 \bLO fis-2 \bRO e'-1 \bLI b-5 \oneVoice \clef treble \bRI dis'-4 \bLO fis'-2 \bRO e'' b'-2 dis'' \chu fis'']-1
  }
  b''4 \chd \oneVoice s4
  \tuplet 6/4 2 {
    | s8 \clef treble \transpose c c'' { fis16[ b f \bLO g \bRO e \bLO b \bRI dis \bLO g \bRO d b] cis[ e c \bLO g \bRO b, \bLI e \bRI ais, \bLO g \bRO a, c gis, e] }
    | \transpose c c' { g[ b fis \bLO e' \bRO f \bLI g \bRI e \bLO b \bRO dis g d b] cis[ e c \bLO g \bRO b, \bLI e \bRI ais, \bLO g \crossStaff { \bRO a, b, as, e] } }
  }
}

voiceD = \transpose c c, {
  \chd
  \voiceTwo
  | \tuplet 3/2 { \once \stemUp e,8 s8 s8 } s2.
  | s1
  | dis4-5 dis'4-5 s2
  | dis4 dis'4 s2
  | fis4 s2.
  | s4
  \transpose c c'' <<
    { \tuplet 3/2 { dis8( cisis8 dis8 } b,4) }
    \new Voice {
      \voiceTwo \tuplet 3/2 { s8. b8-2 b16-2 }
      \voiceOne <fis b>4->
    }
  >>
  \oneVoice \clef bass \once \dynamicUp <b, b>8.\< q16\!
  | \tuplet 3/2 { <e, e>8-^ s8 s8 }
}

dynamics = {
  | s1-\markup \italic "dim."
  | s2\> s2\<
  | s1*4\!
  | s1\ff
  | s2\< s4\! s4\> <>\!
}

sustain = {
  | s4\sustainOn s4-\parenthesize\sustainOn s4\sustainOn s4\sustainOn
  | s4\sustainOn s4\sustainOn s4\sustainOn s4\sustainOn
  | s4\sustainOn s4-\parenthesize\sustainOn s4\sustainOn s4-\parenthesize\sustainOn
  | s4\sustainOn s4-\parenthesize\sustainOn s4\sustainOn s4-\parenthesize\sustainOn
  | s2\sustainOn s4\sustainOn \tuplet 6/4 { s16*5 s16\sustainOn }
  | s4 s4-\parenthesize\sustainOn s2\sustainOn
  | s1*2\sustainOn
}

\paper {
  indent = 0\cm
  page-count = #1
}

\header {
  title = "Fr. Chopin"
  subtitle = "Op. 25 No. 11"
  piece = "No. 42"
  composer = "Leopold Godowsky"
}

\score {
  \new PianoStaff <<
    \new Dynamics \conductor
    \new Staff = "up" {
      \global
      \clef treble
      <<
        \new Voice \voiceA
        \new Voice \voiceB
        \new Voice \voiceC
        \new Voice \voiceD
        s1*8
      >>
    }
    \new Dynamics \dynamics
    \new Staff = "down" {
      \global
      \clef bass
      <<
        \sustain
        s1*8
      >>
    }
  >>
  \layout {
    \context {
      \Score
      \override NonMusicalPaperColumn.line-break-permission = ##f
      \remove "Bar_number_engraver"
    }
    \context {
      \PianoStaff
      \consists #Kneed_span_stem_engraver
    }
    \context {
      \Voice
      \omit TupletBracket
      \omit TupletNumber
    }
  }
}
