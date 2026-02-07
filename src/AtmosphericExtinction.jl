module AtmosphericExtinction


using DataFrames
using DelimitedFiles
using Interpolations
using Measurements
using Unitful




export DeExtinctSpectrum
export ExtinctionLimits
export ExtinctionValues
export ExtinctSpectrum
export GetKnownRecipes
export Recipes








"""
DeExtinctSpectrum(recipe,iwave,ispec,ierrspec,airmass)

# Arguments

- `recipe` is one of the extinction tables available in the package (i.e., those reported by `GetKnownRecipes()`).
- `iwave` is the vector of input wavelengths. They can have units (or assumed to be Angstrom).
- `ispec` is the vector of the input spectrum, in linear units.
- `ierrspec` is the vector of the uncertainties associated to the input spectrum. It cna well be a vector of zeros.
- `airmass` is the airmass associated to the observation.


Returns the input spectrum (in linear units) correcteced for atmospheric extinction.


"""

function DeExtinctSpectrum(recipe,iwave,ispec,ierrspec,airmass)
	if haskey(Recipes,recipe)
		if all(unit.(iwave) .== NoUnits)
			exttbl = airmass .* Recipes[recipe].table(iwave*u"angstrom")
		else
			uconvert.(u"angstrom",iwave)
			exttbl = airmass .* Recipes[recipe].table(iwave)
		end
		extlin = AtmosphericExtinction.Mag2Lin(exttbl)
		spectrum = measurement.(ispec,ierrspec)
		return spectrum ./ extlin
	else
		return nothing
	end
end




"""
ExtinctionLimits(recipe)

# Arguments

- `recipe` is one of the extcintion tables available in the package (i.e., those reported by `GetKnownRecipes()`).

Returns the extinction values wavelength limits in Angstrom.


# Examples
```julia
ExtinctionLimits("Paranal.dat")
```
"""
function ExtinctionLimits(recipe)
    if haskey(Recipes,recipe)
        data = Recipes[recipe].lims
        return ustrip.(data)
    else
        return nothing
    end
end




"""
ExtinctionValues(recipe,waverange)


# Arguments

- `recipe` is one of the extinction tables available in the package (i.e., those reported by `GetKnownRecipes()`).
- `waverange` is a vector of the wavelengths of interest (in Angstrom).


Returns the extinction values for a given wavelength range in Angstrom.


# Examples
```julia
ExtinctionValues("Paranal.dat",3500:3600)
```
"""
function ExtinctionValues(recipe,waverange)
    if haskey(Recipes,recipe)
        data = Recipes[recipe].table(collect(waverange)*u"angstrom")
        return Measurements.value.(data)
    else
        return nothing
    end
end




"""
ExtinctSpectrum(recipe,iwave,ispec,ierrspec,airmass)

# Arguments

- `recipe` is one of the extinction tables available in the package (i.e., those reported by `GetKnownRecipes()`).
- `iwave` is the vector of input wavelengths. They can have units (or assumed to be Angstrom).
- `ispec` is the vector of the input spectrum, in linear units.
- `ierrspec` is the vector of the uncertainties associated to the input spectrum. It cna well be a vector of zeros.
- `airmass` is the airmass associated to the observation.


Returns the input spectrum (in linear units) after atmospheric extinction.

"""
function ExtinctSpectrum(recipe,iwave,ispec,ierrspec,airmass)
	if haskey(Recipes,recipe)
		if all(unit.(iwave) .== NoUnits)
			exttbl = airmass .* Recipes[recipe].table(iwave*u"angstrom")
		else
			uconvert.(u"angstrom",iwave)
			exttbl = airmass .* Recipes[recipe].table(iwave)
		end
		extlin = AtmosphericExtinction.Mag2Lin(exttbl)
		spectrum = measurement.(ispec,ierrspec)
		return spectrum .* extlin
	else
		return nothing
	end
end





"""
GetKnownRecipes()

Returns the atmospheric extinction currently supported by the package.


# Examples
```julia
GetKnownRecipes()
```
"""
function GetKnownRecipes()
    for e in sort(collect(keys(Recipes)))
        println(e)
    end
end



"""
Mag2Lin(excnt)

# Arguments

- `extcnt` is a vector with extinction values in magnitudes (per airmass, usually).


Returns the extinction values in linear units


# Examples
```julia
Mag2Lin([0.5,0.4,0.3])
3-element Vector{Float64}:
 0.6309573444801932
 0.6918309709189364
 0.7585775750291838
```
"""
function Mag2Lin(extcnt)
    return 10 .^ (-0.4 .* (extcnt))
end






"""
ReadData(fname)

# Arguments

- `fname` is the file nama of a given extinction table.

Returns data for an atmospheric extinction currently supported by the package.


# Examples
```julia
ReadData("Paranal.dat")
```
"""
function ReadData(fname)
    extpath = joinpath(@__DIR__,"..","data",fname)
    if fname == "Paranal.dat"
        extdata = readdlm(extpath,Float64,comments=true,comment_char='#')
        exttbl = DataFrame(extdata,vec(["λ", "Ext", "eExt"]))
    else
        extdata = readdlm(extpath,Float64,comments=true,comment_char='#')
        exttbl = DataFrame(extdata,vec(["λ", "Ext"]))
    end
    return exttbl
end




"""
struct RecipeData

# Fields

- `table`: function giving the table interpolation
- `lims`: minimum and maximum wavelengths covered by the inout data.

"""
struct RecipeData
    table
    lims
end



apachetbl = ReadData("Apache.dat")
apachetbl.λ .= apachetbl.λ.*u"angstrom"
#apachefnt = linear_interpolation(apachetbl[!,:λ], apachetbl[!,:Ext], extrapolation_bc=Flat())
apachefull = measurement.(apachetbl[!,:Ext])
apachefnt = linear_interpolation(apachetbl[!,:λ], apachefull, extrapolation_bc=Flat())
apache = RecipeData(apachefnt,[minimum(apachetbl.λ),maximum(apachetbl.λ)])

kitttbl = ReadData("KittPeak.dat")
kitttbl.λ .= kitttbl.λ.*u"angstrom"
#kittfnt = linear_interpolation(kitttbl[!,:λ], kitttbl[!,:Ext], extrapolation_bc=Flat())
kittfull = measurement.(kitttbl[!,:Ext])
kittfnt = linear_interpolation(kitttbl[!,:λ], kittfull, extrapolation_bc=Flat())
kitt = RecipeData(kittfnt,[minimum(kitttbl.λ),maximum(kitttbl.λ)])

lapalmatbl = ReadData("LaPalma.dat")
lapalmatbl.λ .= lapalmatbl.λ.*u"angstrom"
#lapalmafnt = linear_interpolation(lapalmatbl[!,:λ], lapalmatbl[!,:Ext], extrapolation_bc=Flat())
lapalmafull = measurement.(lapalmatbl[!,:Ext])
lapalmafnt = linear_interpolation(lapalmatbl[!,:λ], lapalmafull, extrapolation_bc=Flat())
lapalma = RecipeData(lapalmafnt,[minimum(lapalmatbl.λ),maximum(lapalmatbl.λ)])

lasillatbl = ReadData("LaSilla.dat")
lasillatbl.λ .= lasillatbl.λ.*u"angstrom"
#lasillafnt = linear_interpolation(lasillatbl[!,:λ], lasillatbl[!,:Ext], extrapolation_bc=Flat())
lasillafull = measurement.(lasillatbl[!,:Ext])
lasillafnt = linear_interpolation(lasillatbl[!,:λ], lasillafull, extrapolation_bc=Flat())
lasilla = RecipeData(lasillafnt,[minimum(lasillatbl.λ),maximum(lasillatbl.λ)])

licktbl = ReadData("Lick.dat")
licktbl.λ .= licktbl.λ.*u"angstrom"
#lickfnt = linear_interpolation(licktbl[!,:λ], licktbl[!,:Ext], extrapolation_bc=Flat())
lickfull = measurement.(licktbl[!,:Ext])
lickfnt = linear_interpolation(licktbl[!,:λ], lickfull, extrapolation_bc=Flat())
lick = RecipeData(lickfnt,[minimum(licktbl.λ),maximum(licktbl.λ)])

maunakeatbl = ReadData("MaunaKea.dat")
maunakeatbl.λ .= maunakeatbl.λ.*u"angstrom"
#maunakeafnt = linear_interpolation(maunakeatbl[!,:λ], maunakeatbl[!,:Ext], extrapolation_bc=Flat())
maunakeafull = measurement.(maunakeatbl[!,:Ext])
maunakeafnt = linear_interpolation(maunakeatbl[!,:λ], maunakeafull, extrapolation_bc=Flat())
maunakea = RecipeData(maunakeafnt,[minimum(maunakeatbl.λ),maximum(maunakeatbl.λ)])

paranaltbl = ReadData("Paranal.dat")
paranaltbl.λ .= paranaltbl.λ.*u"angstrom"
#paranalfnt = linear_interpolation(paranaltbl[!,:λ], paranaltbl[!,:Ext], extrapolation_bc=Flat())
paranalfull = measurement.(paranaltbl[!,:Ext],paranaltbl[!,:eExt])
paranalfnt = linear_interpolation(paranaltbl[!,:λ], paranalfull, extrapolation_bc=Flat())
paranal = RecipeData(paranalfnt,[minimum(paranaltbl.λ),maximum(paranaltbl.λ)])

tololotbl = ReadData("CerroTololo.dat")
tololotbl.λ .= tololotbl.λ.*u"angstrom"
#tololofnt = linear_interpolation(tololotbl[!,:λ], tololotbl[!,:Ext], extrapolation_bc=Flat())
tololofull = measurement.(tololotbl[!,:Ext])
tololofnt = linear_interpolation(tololotbl[!,:λ], tololofull, extrapolation_bc=Flat())
tololo = RecipeData(tololofnt,[minimum(tololotbl.λ),maximum(tololotbl.λ)])


Recipes = Dict("Apache Point"=>apache,"Cerro Paranal"=>paranal, "Cerro Tololo"=>tololo, "Kitt Peak"=>kitt, "La Palma"=>lapalma, "La Silla"=>lasilla, "Lick"=>lick, "Mauna Kea"=>maunakea)



end
