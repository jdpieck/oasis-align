#import "../oasis-align.typ": *
// #import "@preview/oasis-align:0.2.0": *
// #import "@local/oasis-align:0.2.0": *

#set page(width: 6in, height: auto, margin: 1in)
#set par(justify: true)
#set grid(column-gutter: .2in)

#let words = [This is me writing about my cat. I love my cat. He is the best of cats. I give him head scratches until he gets mad at me. He then he starts swatting at my hand. This goes on until my hand gets scratched.]

#let cat = image("blanket.jpg")

#oasis-align(
  int-dir: -1, 
  // int-frac: .46,
  // max-iterations: 100,
  // min-frac: .2,
  // debug: true,
  // swap: true,
  cat, 
  words
)

// #grid(columns: (1fr, 1.19fr),  
//   cat, 
//   words
// )

#oasis-align(
  // debug: true,
  // swap: true,
  // min-frac: 0.2,
  image("blanket.jpg"), 
  image("box.jpg"),
)

#oasis-align(
  // debug: true,
  lorem(50),
  lorem(40)
)

// #grid(columns: (1.26fr, 1fr),
//   lorem(50),
//   lorem(40)
// )

#oasis-align(
  // debug: true,
  text(.8em)[This is a passage of text that has smaller size. You might want this for a quote or some cool information that you want to share with the reader.],
  [This is a regularly sized passage of text. This passage has the main content for the things that you are writing about today.]
)
