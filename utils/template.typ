#let main-color = rgb(4, 46, 199)

#let circled_numbering = (n) => {
  let circled_numbers = ("①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨")
  if n >= 1 and n < 10 {
    circled_numbers.at(n - 1)
  } else {
    [#n.]
  }
}

#let outline-rules(doc) = {
  set text(font: "TeX Gyre Heros", hyphenate: false, lang: "es")
  set par(justify: true)
  set page("us-letter")
  //show smallcaps: set text(font: "Lato")
  show raw: set text(font: "IBM Plex Mono", size: 10pt)
  show heading: it => upper(it)
  set text(size: 11pt)
  doc
}

#let main-rules(doc) = {
  set text(
    font: "TeX Gyre Heros",
    hyphenate: false, 
    lang: "es", 
    size: 11pt, 
    fill: black
  )
  set par(justify: true)
  set table(stroke: 0.5pt)
  set list(indent: 5pt)
  set enum(numbering: circled_numbering, indent: 5pt)
  set heading(numbering: "1.")
  show heading: it => [ 
    #let fixed-size = 14 - it.level
    #set text(size: fixed-size * 1pt)
    #upper(it)
  ]
  show math.equation.where(block: false): box
  //show smallcaps: set text(font: "Lato")
  show raw: set text(font: "IBM Plex Mono", size: 10pt)
  show link: set text(fill: main-color)
  show link: strong
  show ref: set text(fill: main-color)
  show selector(enum).or(list): it => {
    show math.equation.where(block: true): block.with(width: 100%)
    it
  }

  page(
    paper: "us-letter",
    header: none,
    footer: none,
    margin: 0pt,
    image("../images/cover.svg")
  )

  counter(page).update(1)
  set page(
    paper: "us-letter",
    header: none
  )

  outline()
  pagebreak(weak: true)

  set page(numbering: "1", "us-letter", header: [
    #set align(center)
    #set text(fill: luma(50%))
    --- APUNTE MDS7101 2025/1 ---
  ], footer: [
    #set align(center)
    #set text(fill: luma(50%))
    #context (counter(page).display(here().page-numbering()))
  ])
  counter(page).update(1)

  doc
}

#let cal(it) = math.class("normal", box({
  show math.equation: set text(font: "Garamond-Math", stylistic-set: 3)
  $#math.cal(it)$
}) + h(0pt))

#let keyword(str) = {
  set text(fill: main-color)
  str
}