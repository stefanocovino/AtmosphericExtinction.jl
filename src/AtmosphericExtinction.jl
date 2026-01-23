module AtmosphericExtinction


using DataFrames
using DelimitedFiles
using Interpolations
using Unitful




export GetKnownRecipes
export Recipes


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
ReadData(fname)

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

#Arguments

- `table`: table interpolation
- `lims`: minimum and maximum wavelengths

"""
struct RecipeData
    table
    lims
end



apachetbl = ReadData("Apache.dat")
apachetbl.λ .= apachetbl.λ.*u"angstrom"
apachefnt = linear_interpolation(apachetbl[!,:λ], apachetbl[!,:Ext], extrapolation_bc=Flat())

apache = RecipeData(apachefnt,[minimum(apachetbl.λ),maximum(apachetbl.λ)])

kitttbl = ReadData("KittPeak.dat")
kitttbl.λ .= kitttbl.λ.*u"angstrom"
kittfnt = linear_interpolation(kitttbl[!,:λ], kitttbl[!,:Ext], extrapolation_bc=Flat())

kitt = RecipeData(kittfnt,[minimum(kitttbl.λ),maximum(kitttbl.λ)])

lapalmatbl = ReadData("LaPalma.dat")
lapalmatbl.λ .= lapalmatbl.λ.*u"angstrom"
lapalmafnt = linear_interpolation(lapalmatbl[!,:λ], lapalmatbl[!,:Ext], extrapolation_bc=Flat())

lapalma = RecipeData(lapalmafnt,[minimum(lapalmatbl.λ),maximum(lapalmatbl.λ)])

lasillatbl = ReadData("LaSilla.dat")
lasillatbl.λ .= lasillatbl.λ.*u"angstrom"
lasillafnt = linear_interpolation(lasillatbl[!,:λ], lasillatbl[!,:Ext], extrapolation_bc=Flat())

lasilla = RecipeData(lasillafnt,[minimum(lasillatbl.λ),maximum(lasillatbl.λ)])

licktbl = ReadData("Lick.dat")
licktbl.λ .= licktbl.λ.*u"angstrom"
lickfnt = linear_interpolation(licktbl[!,:λ], licktbl[!,:Ext], extrapolation_bc=Flat())

lick = RecipeData(lickfnt,[minimum(licktbl.λ),maximum(licktbl.λ)])

maunakeatbl = ReadData("MaunaKea.dat")
maunakeatbl.λ .= maunakeatbl.λ.*u"angstrom"
maunakeafnt = linear_interpolation(maunakeatbl[!,:λ], maunakeatbl[!,:Ext], extrapolation_bc=Flat())

maunakea = RecipeData(maunakeafnt,[minimum(maunakeatbl.λ),maximum(maunakeatbl.λ)])

paranaltbl = ReadData("Paranal.dat")
paranaltbl.λ .= paranaltbl.λ.*u"angstrom"
paranalfnt = linear_interpolation(paranaltbl[!,:λ], paranaltbl[!,:Ext], extrapolation_bc=Flat())

paranal = RecipeData(paranalfnt,[minimum(paranaltbl.λ),maximum(paranaltbl.λ)])

tololotbl = ReadData("CerroTololo.dat")
tololotbl.λ .= tololotbl.λ.*u"angstrom"
tololofnt = linear_interpolation(tololotbl[!,:λ], tololotbl[!,:Ext], extrapolation_bc=Flat())

tololo = RecipeData(tololofnt,[minimum(tololotbl.λ),maximum(tololotbl.λ)])


#Recipes = Dict("Apache Point"=>apachefnt,"Cerro Paranal"=>paranalfnt, "Cerro Tololo"=>tololofnt, "Kitt Peak"=>kittfnt, "La Palma"=>lapalmafnt, "La Silla"=>lasillafnt, "Lick"=>lickfnt, "Mauna Kea"=>maunakeafnt)

Recipes = Dict("Apache Point"=>apache,"Cerro Paranal"=>paranal, "Cerro Tololo"=>tololo, "Kitt Peak"=>kitt, "La Palma"=>lapalma, "La Silla"=>lasilla, "Lick"=>lick, "Mauna Kea"=>maunakea)



end
