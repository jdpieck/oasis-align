#import "utils.typ": *

#let oasis-align-images(
  vertical: false,
  swap: false, 
  margin: 0pt,
  image1, 
  image2
) = context {

  assert(type(vertical) == bool, message: "Vertical parameter condition must be true or false!")
  assert(type(swap) == bool, message: "Swap parameter must be true or false!")

  
  layout(measured-container => {
    // Measure size of container
    let container-side = if vertical { measured-container.height } else { measured-container.width }
    let margins = process-margin(margin, container-side)
    let gutter = process-gutter(vertical, container-side)

    // Find dimensional ratio between images
    let block1 = measure(image1)
    let block2 = measure(image2)
    let ratio = if vertical {(block1.height/block1.width)*block2.width/block2.height}
                else {(block1.width/block1.height)*block2.height/block2.width}
    
    let max-dim = container-side - gutter - margins.first() - margins.last()
    // Set widths of images
    let calcWidth1 = (max-dim)/(1/ratio + 1)
    let calcWidth2 = (max-dim)/(ratio + 1)

    // Display images in grid
    display-output(image1, image2, calcWidth1, calcWidth2, vertical, swap, margins, false, 0pt)
  })
}
