# AtmosphericExtinction.jl

[![Build Status](https://github.com/stefanocovino/AtmosphericExtinction.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/stefanocovino/AtmosphericExtinction.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://stefanocovino.github.io/AtmosphericExtinction.jl/stable/)


This is a very simple package providing a convenience function to access to atmoshperic extinction tables in the optical bands.

## Installation


```julia
using Pkg
Pkg.add(url="https://github.com/stefanocovino/AtmoshpericExtinction.jl.git")
```

or

```julia
using Pkg
Pkg.add("AtmoshpericExtinction")
```

will install this package, with the latter when the package (if ever) will be registered.


[Here](https://stefanocovino.github.io/AtmosphericExtinction.jl/stable/)'s the documentation!


## Possible use

A list of the known site can be obtained by:

```julia
GetKnownRecipes()
```
```
Cerro Pachon
Cerro Paranal
La Palma
La Silla
Mauna Kea
```

We plan to add as many site information as possible in the future.

The extinction (magnitude/airmass) for any given available observing site, e.g. La Silla, can be obtained by:

```julia
Recipes["La Silla"](3500:4000)
```

Wavelength should be expressed in Angstrom.


### Available recipes

This is a plot showing the recipes at present available:

![Histogram](docs/src/recipes.png)


