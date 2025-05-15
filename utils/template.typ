#import "functions.typ": circled_numbering
#import "variables.typ": main-color, global-font, section-spacing

#let outline-rules(doc) = {
  set text(font: global-font, hyphenate: false, lang: "es")
  set par(justify: true)
  set page("us-letter")
  show raw: set text(font: "IBM Plex Mono", size: 10pt)
  show heading: it => upper(it)
  set text(size: 11pt)
  doc
}

#let main-rules(doc) = {
  set text(
    font: global-font,
    hyphenate: false, 
    lang: "es", 
    size: 11pt, 
    fill: black
  )
  set par(justify: true, first-line-indent: (amount: 1.5em, all: true))
  show block: set par(first-line-indent: 0pt)
  set table(stroke: 0.5pt)
  set list(indent: 5pt)
  set enum(numbering: circled_numbering, indent: 5pt)
  show heading: set block(below: 1em)
  set heading(numbering: "1.")
  show heading.where(outlined: true): it => [ 
    #v(section-spacing)
    #if it.level == 1 {
      set text(size: 14pt)
      let section = context counter(heading).get().at(0)
      block(
        stroke: 0.5pt,
        inset: 10pt,
        width: 100%,
        grid(
          columns: (70%, 30%),
          align: (start + horizon, end + horizon),
          [
            #set par(first-line-indent: 0pt, justify: false)
            #smallcaps[
              #set text(weight: "regular")
              Semana #section
            ] \ #it.body
          ],
          [
            #image("../images/mds_logo.svg", width: 150pt)
          ]
        )
      )
    } else {
      let fixed-size = 14 - it.level
      set text(size: fixed-size * 1pt)
      upper(it)
    }
    #v(section-spacing)
  ]
  show math.equation.where(block: false): box
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