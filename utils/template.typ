#let main-color = rgb(50, 0, 193)

#let main-rules(doc) = {
  set text(
    font: "TeX Gyre Heros", 
    hyphenate: false, 
    lang: "es", 
    size: 11pt, 
    fill: black
  )
  set page(numbering: "1", "us-letter", header: [
    #set align(center)
    #set text(fill: luma(50%))
    --- APUNTE MDS7101 2025/1 ---
  ], footer: [
    #set align(center)
    #set text(fill: luma(50%))
    #context (counter(page).display(here().page-numbering()))
  ])
  set par(justify: true)
  set table(stroke: 0.5pt)
  set list(indent: 5pt)
  set enum(indent: 5pt)
  set heading(numbering: "1.")
  show heading: it => [ 
    #let fixed-size = 14 - it.level
    #set text(size: fixed-size * 1pt)
    #upper(it)
  ]
  //show math.equation: set text(font: "TeX Gyre Pagella Math")
  show math.equation.where(block: false): box
  //show smallcaps: set text(font: "Lato")
  //show raw: set text(font: "IBM Plex Mono", size: 10pt)
  show link: set text(fill: main-color)
  show link: strong
  show ref: set text(fill: main-color)
  show selector(enum).or(list): it => {
    show math.equation.where(block: true): block.with(width: 100%)
    it
  }

  doc
}

#let outline-rules(doc) = {
  set text(font: "TeX Gyre Heros", hyphenate: false, lang: "es")
  set par(justify: true)
  set page("us-letter")
  //show smallcaps: set text(font: "Lato")
  //show raw: set text(font: "IBM Plex Mono", size: 10pt)
  show heading: it => upper(it)
  set text(size: 11pt)
  doc
}

#let keyword(str) = {
  set text(fill: main-color)
  str
}