# oasis-align 
`oasis-align` is a package that automatic sizes your content so that their heights are equal, perfect for placing content side by side. 

# Examples

# Configuration 
To use `oasis-align` in your document, start by importing the package like this:
```typst
#import "@preview/oasis-align:0.1.0": *
```

There are two functions associated with this package. The first is specifically targeted at aligning images, and the second is targeted at content in general

> [!important]
> To change the size of the gutter in both functions, use `#set grid(column-gutter: length)`. This is case to allow for set rules which are not possible with user-defined functions. 

## `oasis-align-images`
Use this function to align two images.

```typst
#oasis-align-images(
    "path/to/image1",
    "path/to/image2"
)
```

> [!tip]
> Whenever aligning **only** images, its best to use this function over the default `oasis-align`. _To learn more about why, check out the next section._


## `oasis-align`
Use this function to align content like text with other content like images or figures.

> [!tip]
> The parameters with defined values are the defaults and do not need to need to be included unless desired.

```typst
#oasis-align(
  item1,                // content
  item2,                // content
  int-frac: 0.5,        // decimal between 0 and 1
  tolerance: 0.001pt,   // length
  max-iterations: 50,   // integer greater than 0
  int-dir: 1,           // 1 or -1
  debug: false          // boolean
)
```
### Parameters
#### `int-frac`
The starting point of search process. You may want to change this value to reduce the number of iterations it takes to find the best alignment.

#### 'tolerance'
The allowable difference in heights between `item1` and `item2`. The function will run until it has reached either this tolerance or `max-iterations`. Making this value larger may reduce the total number of iterations and result in a larger height difference between pieces of content.  

> [!note]
> Two pieces of content may not always be able to achieve the desired tolerance. In the case that it is unable to achieve a height difference less than `tolerance`, the function sizes the content to the iteration that had the least difference in height. 

#### 'max-iterations'
The maximum number of iterations the function is allowed to attempt before terminating. Increasing this number may allow you to achieve a smaller `tolerance`.

#### `int-dir`
The initial direction that the dividing fraction is moved. Changing this value will change the initial direction.

> [!note]
> The program is hardcoded to change directions if a solution is not found in the selected direction. This parameter mainly serves to let you choose between multiple solutions which is common between an image and a block of text.

#### 'debug'
A toggle to let you look inside the function and see what is happening. This is useful if you would like to understand why certain content may be incompatible and which of the parameters above could be changed to resolve the issue. 

# FAQ

## Why won't my image align nicely with my text


# How It Works
## `oasis-align-images`
The function starts by determining the ratio between the width and height of the selected images. This ratio can then be used to solve set of linear equations that give the width that each image should be to have equal height. 

## `oasis-align`
Originally designed to allow for an image to be placed side-by-side with text, this function takes an iterative approach to aligning the content. When changing the width of a block of text, the height does not scale linearly, but rather as a step function that follows an exponential trend. This prevents the use of an analytical methodology, and thus must be solved using an iterative approach.

The function starts by taking the available space and then spiting it using the `int-frac`. The content is then placed in a block with the width as determined above before measuring its height. Base on the `int-dir`, the split will be moved left or right using the bisection method until a solution within the `tolerance` has been found. In the case that 


# Nomenclature
"Oasis" as in a fertile spot in a desert, where water is found.
