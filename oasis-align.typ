#let oasis-align(
  swap: false,
  vertical: false,
  range: (0, 1),
  int-frac: none, 
  int-dir: 1, 
  min-frac: 0.05,
  frac-limit: 1e-5,  
  tolerance: 0.01pt,
  force1: none,
  force2: none,
  max-iterations: 30, 
  debug: false,
  item1, 
  item2, 
) = context {

  let check-fraction(parameter) = (type(parameter) == float or parameter == 1  or parameter == 0) and parameter >= 0 and parameter <= 1

  // Check that inputs are valid
  assert(type(swap) == bool, message: "Swap parameter must be true or false!")
  assert(type(vertical) == bool, message: "Vertical parameter condition must be true or false!")
  assert(type(range) == array and range.len() == 2 and range.all(it => check-fraction(it)), message: "Range must be an array of two fractions!")
  assert(int-dir == -1 or int-dir == 1, message: "Initial direction parameter must be 1 or -1!")
  assert(int-frac == none or check-fraction(int-frac), message:"Initial fraction must be between 0 and 1!")
  assert(int-frac == none or {int-frac >= range.first() and int-frac <= range.last()}, message:"Initial fraction must fall within user-defined range!")
  assert(check-fraction(min-frac), message: "Minimum fraction must be between 0 and 1!")
  assert(range.last() - range.first() > min-frac, message: "The range must me larger than the minimum-fraction")
  assert(type(tolerance) == length, message: "Tolerance must be a length!")
  assert(force1 == none or force2 == none, message: "You cannot force the dimension of item1 and item2 at the sane time!")
  assert(force1 == none or check-fraction(force1), message: "The forced dimension must be given in terms of a fraction!")
  assert(force2 == none or check-fraction(force2), message: "The forced dimension must be given in terms of a fraction!")


  // Debug functions
  let heads-up(message) = if debug {block(text(blue, weight: "bold", message))}
  let warning(message) = if debug {block(text(red.darken(15%), weight: "bold", message))}
  let success(message) = if debug {block(text(green.darken(30%), weight: "bold", message))}
  let system-info(message) = if debug {
    show raw.where(block: false): box.with(
        fill: luma(240),
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
      )  

      message
  }
  
  
  // use layout to measure container
  layout(container => {

    let gutter = if vertical {
      if grid.row-gutter == () {0pt} // In case grid.gutter is not defined
      else {grid.row-gutter.at(0)}
    } else {
      if grid.column-gutter == () {0pt} // In case grid.gutter is not defined
      else {grid.column-gutter.at(0)}
    }

    let max-dim = if vertical {container.height - gutter}
                   else {container.width - gutter}

    let dim-1a    // Bounding dimension of item1
    let dim-2a    // Bounding dimension of item2
    let dim-1b   // Measured dimension of item1 using dim-1a
    let dim-2b   // Measured dimension of item2 using dim-2a
    let start-frac = if int-frac == none {(range.last() + range.first())/2} else {int-frac}
    // let start-frac = .5
    let frac = start-frac
    let previous-frac 
    let frac-diff = start-frac
    let lower-frac = range.first() 
    let upper-frac = range.last()
    let diff      // Difference in heights of item1 and item2
    let dir = int-dir
    let min-diff = max-dim
    let best-frac
    let n = 0
    let swap-check = 0

    let split-layout(max-distance, fraction) = {
      let dim1 = fraction * max-distance
      let dim2 = (1 - fraction) * max-distance
      return (dim1, dim2)
    }

    // Loop max to prevent infinite loop
    while n < max-iterations {
      n = n + 1
      system-info(heading(level: 3, [Iteration #n]))

      // If there is no solution in the initial direction, change directions and reset the function.
      // if frac < min-frac + range.first() or frac > range.last() - min-frac {
      if frac-diff < frac-limit {
        warning([Minimum width reached. Changing `dir`...])
        swap-check = swap-check + 1
        dir = dir *-1
        frac = start-frac
        lower-frac = range.first() 
        upper-frac = range.last()
      }      


      (dim-1a, dim-2a) = split-layout(max-dim, frac)


      // Measure height of content and find difference
      dim-1b = measure(block(width: dim-1a, item1)).height.to-absolute()
      dim-2b = measure(block(width: dim-2a, item2)).height.to-absolute()
      diff = calc.abs(dim-1b - dim-2b)
      
      system-info()[
          // item1: (#dim-1a, #dim-1b) \ 
          // item2: (#dim-2a, #dim-2b) \ 
          Height Diff: #diff #h(1em) 
          Min Diff: #min-diff \ 
          Frac: #frac \ 
          Upper: #upper-frac #h(1em) 
          Lower: #lower-frac 
        ]

      // Keep track of the best fraction
      if diff < min-diff {
        success([`diff` is smaller. Assigning new `min-diff`...])
        best-frac = frac
        min-diff = diff
      }
      else if diff > min-diff {
        heads-up([`diff` is larger than `min-diff`.])
      }
      else {heads-up([`min-diff` did not change])}
     
      if diff < tolerance {success("Tolerance Reached!")}
      // if n >= max-iterations {warning("Maximum number of iterations reached!")}
      if swap-check >= 2 {warning([`dir` has changed twice. The selected content cannot be more closely aligned. Try changing `int-frac` to give the function a different starting point.])      }

      // Check if within tolerance. If so, display
      if diff < tolerance or n >= max-iterations or swap-check >= 2 {
        success([Displaying output...])
        if swap {grid(columns: (dim-2a, dim-1a), item2, item1)}
        else    {grid(columns: (dim-1a, dim-2a), item1, item2)}
        break
      }
      // Use bisection method by setting new bounds
      else if dim-1b*dir > dim-2b*dir {
        upper-frac = frac
        heads-up([Reassigning `upper-bound` to #upper-frac])
      }
      else if dim-1b*dir < dim-2b*dir {
        lower-frac = frac
        heads-up([Reassigning `lower-bound` to #lower-frac])
      }
      else {panic("Unknown Error")}

      // Bisect length between bounds to get new fraction
      previous-frac = frac
      frac = (lower-frac + upper-frac) / 2
      frac-diff = calc.abs(frac - previous-frac)

      system-info()[
        // New lower bound: #lower-frac \
        // New upper bound: #upper-frac \
        // Old fraction: #previous-frac \
        // New fraction: #frac \
        Fraction diff: #frac-diff
      ]

      // Change fraction so value with least height difference if tolerance was not achieved
      if n >= max-iterations - 1 {
        warning([Maximum number of iterations reached! Setting fraction to fraction with smallest `diff`])
        frac = best-frac
      }
    }
  })
}

#import "oasis-align-vert.typ": *