#set page(width: 3in, height: auto, margin: .25in)

#let thing = [content]

#thing

// #let thingd.things = [content]

#let thing = (
  thing1: 4,
  thing2: [content 2]
)

#thing.thing1

#thing.thing2


#{
  thing.thing1 = 6
  thing.thing2 = [better content]
}

#thing.thing1
#thing.thing2
