#let main-color = rgb(4, 46, 199)
#let global-font = "TeX Gyre Heros"
#let section-spacing = 0.25em

#let std(va) = $"STD"(#va)$
#let var(X) = $VV"ar"(#X)$
#let cov(X, Y) = $CC"ov"(#X, #Y)$
#let corr(X, Y) = $"Corr"(#X, #Y)$

/** 
 * This is a special function, and it's not placed
 * in the utils/functions.typ file because it would
 * cause a circular dependency.
 */
#let cal(it) = math.class("normal", box({
  show math.equation: set text(font: "Garamond-Math", stylistic-set: 3)
  $#math.cal(it)$
}) + h(0pt))
#let normal = $cal(N)$

#let Ber = "Bernoulli"
#let Bin = "Binomial"
#let MultBin = "Multinomial"
#let Poisson = "Poisson"

#let example-box(title: "", body) = block(
  stroke: (left: 1.5pt),
  inset: 1em,
  [
    #let example-decorator
    #let comparator

    #if type(title) == str {
      comparator = title.len() > 0
    } else if type(title) == content {
      let child = title.fields().at("children")
      comparator = child.len() > 0
    }

    #if comparator {
      example-decorator = "."
    }

    #set par(first-line-indent: 0pt)
    #strong[Ejemplo#example-decorator]
    #if comparator {
      emph[#title]
    }

    #body
  ]
)