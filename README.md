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
Apache Point
Cerro Paranal
Cerro Tololo
Kitt Peak
La Palma
La Silla
Lick
Mauna Kea
```

We plan to add as many site information as possible in the future.

The extinction (magnitude/airmass) for any given available observing site, e.g. La Silla, can be obtained by:

```julia
Recipes["La Silla"](3500:4000)
```

Wavelength should be expressed in Angstrom.


This is a plot showing the recipes at present available:

![Histogram](docs/src/recipes.png)


### References

These are the references for the availbale atmoshperic extinction tables, partly derived from data included in the [specreduce](https://specreduce.readthedocs.io/en/latest/index.html) `python` packge.

- The extinction table for the *Apache Point Observatory* is based on the extinction table used for the [SDSS](https://www.apo.nmsu.edu/arc35m/Instruments/DIS/).
- The extinction table for the Cerro Paranal is taken from [Patat et al. (2011)](https://ui.adsabs.harvard.edu/abs/2011A%26A...527A..91P/abstract). This is the only case where the uncertainties on the extinction are reported.
- The extinction table for the Cerro Tololo is taken from the calibration data included in [IRAF](https://en.wikipedia.org/wiki/IRAF).
- The extinction table for the Kitt Peak is taken from the calibration data included in [IRAF](https://en.wikipedia.org/wiki/IRAF).
- The extinction table for La Palma is taken from the technical note [King (1985)](https://www.ing.iac.es/Astronomy/observing/manuals/ps/tech_notes/tn031.pdf).
- The extinction table for La Silla is taken from the [ESO website](https://www.eso.org/sci/observing/tools/Extinction.html).
- The extinction table for the Lick Observatory is taken from [these tables](https://mthamilton.ucolick.org/techdocs/standards/lick_mean_extinct.html).
- The extinction curve for the Manua Kea is taken from [Buton et al. (2013](https://mthamilton.ucolick.org/techdocs/standards/lick_mean_extinct.html).


We are glad to include more extinction tables, if availbale.

