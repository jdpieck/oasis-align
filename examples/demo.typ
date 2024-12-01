#import "../oasis-align.typ": *
// #import "@preview/oasis-align:0.1.0": *
// #import "@local/oasis-align:0.1.1": *

#set page(width: 6in, height: auto, margin: 1in)
#set image(width: 100%)
#set par(justify: true)
#set grid(column-gutter: .2in)

#let words = [This is me writing about my cat. I love my cat. He is the best of cats. I give him head scratches until he gets mad at me. He then he starts swatting at my hand. This goes on until my hand gets scratched. 
dsfdggs7 sdjk f sdfkj sdfkjs dkfj dskj skdf jdsk dsk skd ksd ksd sdk sk skdj ks sdkskfjsdkfjskdfjsk kdsjf ksdfjskdj ks jkd jskdksf ksd sdkskdfjsdfk skdjf kdsjf kdsfjskdfjsdk gfd gf dfgdfg dfg dfg df
]

#let cat = image("blanket.jpg")

#oasis-align(int-dir:1, 
debug:true,
  cat, 
  words
)

#grid(columns: (1fr, 1.19fr),  
  cat, 
  words
)

// #oasis-align(
//   debug: true,
//   swap: true,
//   image("blanket.jpg"), 
//   image("box.jpg"),
// )


// #oasis-align(
//   text(.8em)[This is a passage of text that has smaller size. You might want this for a quote or some cool information that you want to share with the reader.],
//   [This is a regularly sized passage of text. This passage has the main content for the things that you are writing about today.]
// )
