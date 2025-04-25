#let main-color = rgb(4, 46, 199)

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