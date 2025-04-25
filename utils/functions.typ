#import "variables.typ": main-color

#let circled_numbering = (n) => {
  let circled_numbers = ("①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨")
  if n >= 1 and n < 10 {
    circled_numbers.at(n - 1)
  } else {
    [#n.]
  }
}

#let annotate(ret) = {
  set text(fill: main-color)
  ret
}