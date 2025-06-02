#let oasis-align(
  swap: false,
  int-dir: 1, 
  int-frac: 0.5, 
  min-frac: 0.05,  
  tolerance: 0.01pt,
  max-iterations: 30, 
  force-columns: none,
  debug: false,
  item1, 
  item2, 
) = context {

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

  // Check that inputs are valid
  if int-frac <= 0 or int-frac >= 1 {panic("Initial fraction must be between 0 and 1!")}
  if min-frac <= 0 or min-frac >= 1 {panic("Minimum fraction must be between 0 and 1!")}
  if int-dir != -1 and int-dir != 1 {panic("Direction must be 1 or -1!")}
  if type(tolerance) != length {panic("Tolerance must be a length!")}
  
  // use layout to measure container
  layout(container => {
    let gutter = if grid.column-gutter == () {0pt} // In case grid.gutter is not defined
                 else {grid.column-gutter.at(0)}
    let max-width = container.width - gutter
    // gutter = gutter.to-absolute() doesn't work idk    
    let width1    // Bounding width of item1
    let width2    // Bounding width of item2
    let height1   // Measured height of item1 using width1
    let height2   // Measured height of item2 using width2
    let frac = int-frac
    let upper-frac = 1
    let lower-frac = 0 
    let diff      // Difference in heights of item1 and item2
    let dir = int-dir
    let min-diff = max-width
    let best-frac
    let n = 0
    let swap-check = 0

    // Loop max to prevent infinite loop
    while n < max-iterations {
      n = n + 1

      // If there is no solution in the initial direction, change directions and reset the function.
      if frac < min-frac or frac > 1 - min-frac {
        heads-up([Minimum width reached. Changing `dir`...])
        swap-check = swap-check + 1
        dir = dir *-1
        frac = int-frac
        upper-frac = 1
        lower-frac = 0 

        // If this is the second time that a solution as not been found, terminate the function.
        if swap-check >= 1 {
          warning([`dir` has changed twice. The selected content cannot be more closely aligned. Try changing `int-frac` to give the function a different starting point.])
        }
      }

      // Set starting bounds
      width1 = frac*max-width
      width2 = (1 - frac)*max-width

      // Measure height of content and find difference
      height1 = measure(block(width: width1, item1)).height.to-absolute()
      height2 = measure(block(width: width2, item2)).height.to-absolute()
      diff = calc.abs(height1 - height2)
      
      // Display current values
      system-info[ 
        #heading(level: 3, [Iteration #n])
         item1: (#width1, #height1) \ 
         item2: (#width2, #height2) \ 
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

      // Check if within tolerance. If so, display
      if diff < tolerance or n >= max-iterations or swap-check >= 2 {
        success([Displaying output...])
        if swap {grid(columns: (width2, width1), item2, item1)}
        else    {grid(columns: (width1, width2), item1, item2)}
        break
      }
      // Use bisection method by setting new bounds
      else if height1*dir > height2*dir {
        upper-frac = frac
        heads-up([Reassigning `upper-bound`...])
      }
      else if height1*dir < height2*dir {
        lower-frac = frac
        heads-up([Reassigning `lower-bound`...])
      }
      else {panic("Unknown Error")}

      // Bisect length between bounds to get new fraction
      frac = (lower-frac + upper-frac) / 2

      // Change fraction so value with least height difference if tolerance was not achieved
      if n >= max-iterations - 1 {
        warning([Maximum number of iterations reached! Setting fraction to fraction with smallest `diff`])
        frac = best-frac
      }
    }
  })
}

#import "oasis-align-vert.typ": *