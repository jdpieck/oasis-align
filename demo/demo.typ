// #import "../oasis-align.typ": *
// #import "../oasis-align-images.typ": *
#import "../lib.typ": *
// #import "@preview/oasis-align:0.2.0": *
// #import "@local/oasis-align:0.2.0": *
// 

#set page(width: 6in, height: auto, margin: 1in)
#set par(justify: true)
// #set grid(column-gutter: .2in)
#set grid(column-gutter: 4%)

#let words = [This is me writing about my cat. I love my cat. He is the best of cats. I give him head scratches until he gets mad at me. He then he starts swatting at my hand. This goes on until my hand gets scratched.]

#let cat = image("blanket.jpg")
#let cat-fig = [#figure(
  cat, 
  caption: [This is a caption]
) <thihng>]

// #cat.func()
// #cat-fig.func()
// #cat-fig.fields()
// #repr(cat-fig)

#cat-fig.children.at(0).func()
#cat-fig.func()
#type(cat-fig)


// #cat-fig.has("label")

// #cat-fig.body.func()


// #place(line(length: 2in, angle: 90deg, stroke: 5pt))

// #let thing = 1pt + 0%
// #type(thing)
// #thing.length
// #thing.ratio

// #repr(cat)
// #cat.source
// #type(cat)

// #image("blanket.jpg", width: 6% + 1in)


#oasis-align-figures(
  // margin: 50pt, 
  [#figure(
    cat,
    caption: [caption1 is really long and ],
  ) <sdfs>],
  figure(
    image("box.jpg"),
    caption: [],
  )
)



#oasis-align(
  // margin: 6% ,
  // margin: 20pt + 5%,
  // margin: 9pt,
  margin: (15pt + 3em, 5pt + 7%),
  // margin: (0in, 5pt),
  // margin: (1in, 5pt),
  // margin: (0in, 5pt),
  // int-dir: -1, 
  // force1: true,
  range: (0.5, 1),
  // range: (0, .75),
  // int-frac: .6,
  // force-frac: .4, 
  // int-frac: .46,
  // max-iterations: 100,
  // min-frac: .2,
  // debug: true,
  // swap: true,
  // ruler: true,
  cat, 
  words
)

// #v(3em)
// // #grid(columns: (1fr, 1.19fr),  
// //   cat, 
// //   words
// // )

// #oasis-align(
//   // debug: true,
//   int-dir: -1,
//   force-frac: .5,
//   // vertical: true,
//   // swap: true,
//   // min-frac: 0.2,
//   ruler: true,
//   image("blanket.jpg"), 
//   image("box.jpg"),
// )
// #set grid(gutter: 2em)
#oasis-align-images(
  // debug: true,
  // int-dir: -1,
  // vertical: true,
  // swap: true,
  // min-frac: 0.2,
  // ruler: true,
  // margin: (30pt, 30%),
  image("blanket.jpg"), 
  image("box.jpg"),
  // path("blanket.jpg"), 
  // path("box.jpg"),
  // "blanket.jpg", 
  // "box.jpg",
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
  range: (.2, .878),
  text(.8em)[This is a passage of text that has smaller size. You might want this for a quote or some cool information that you want to share with the reader.],
  [This is a regularly sized passage of text. This passage has the main content for the things that you are writing about today.]
)

#set page(width: auto, height: 6in)
#set grid(row-gutter: .2in)
#set image(fit: "contain")

// #oasis-align-vert(words, cat)
#pagebreak()
#oasis-align-images(
  // debug: true,
  vertical: true,
  // ruler: true,
  image("blanket.jpg"), 
  image("box.jpg"),
)

#pagebreak()
#oasis-align(
  vertical: true,
  swap: true,
  margin: (0pt, 5pt),
  image("blanket.jpg"),
  image("box.jpg"),
)

#oasis-align(
  // debug: true,
  vertical: true,
  ruler: true,
  figure(image("blanket.jpg"), caption: [a kitty]), 
  figure(image("box.jpg"), caption: [a kitty]),
)
#pagebreak()
#set grid(inset: (bottom: .2in))
#oasis-align(
  vertical: true,
  ruler: true,
  // debug: true,
  // swap: true,
  block(figure(image("blanket.jpg"), caption: [a kitty])), 
  figure(image("box.jpg"), caption: [a kitty]),
  // figure(image("blanket.jpg"))
)


// #oasis-align-vert(words, words)

// #grid(
//   rows:(1fr, 2fr), 
//   // words, words
//     figure(image("blanket.jpg"), caption: [a kitty]), 
//   figure(image("box.jpg"), caption: [a kitty]),
// )