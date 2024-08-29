# oasis-align 
`oasis-align` is a package that automatic sizes your content so that they are as best aligned as possible.

# Configuration 
There are two main functions associated with this package. The first is specifically target at aligning images, and the second is targeted at content in general

> [!important]
> To change the size of the gutter in both functions, use `#set grid(gutter: length)`{:.typst}. This is case to allow for set rules which are not possible with user-defined functions. 

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

> [!note]
> The parameters with defined values are the defaults and do not need to need to be included. 

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
- `int-frac`: The start position wh

# FAQ


# How It Works
## `oasis-align-images`
The function starts by determining the ratio between the width and height of the selected images. This ratio can then be used to solve set of linear equations that give the width that each image should be to have equal height. 

## `oasis-align`


# Nomenclature
"Oasis" as in a fertile spot in a desert, where water is found.
