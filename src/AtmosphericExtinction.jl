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



apachetbl = ReadData("Apache.dat")
apachetbl.λ .= apachetbl.λ.*u"angstrom"
apachefnt = linear_interpolation(apachetbl[!,:λ], apachetbl[!,:Ext])

kitttbl = ReadData("KittPeak.dat")
kitttbl.λ .= kitttbl.λ.*u"angstrom"
kittfnt = linear_interpolation(kitttbl[!,:λ], kitttbl[!,:Ext])

lapalmatbl = ReadData("LaPalma.dat")
lapalmatbl.λ .= lapalmatbl.λ.*u"angstrom"
lapalmafnt = linear_interpolation(lapalmatbl[!,:λ], lapalmatbl[!,:Ext])

lasillatbl = ReadData("LaSilla.dat")
lasillatbl.λ .= lasillatbl.λ.*u"angstrom"
lasillafnt = linear_interpolation(lasillatbl[!,:λ], lasillatbl[!,:Ext])

licktbl = ReadData("Lick.dat")
licktbl.λ .= licktbl.λ.*u"angstrom"
lickfnt = linear_interpolation(licktbl[!,:λ], licktbl[!,:Ext])

maunakeatbl = ReadData("MaunaKea.dat")
maunakeatbl.λ .= maunakeatbl.λ.*u"angstrom"
maunakeafnt = linear_interpolation(maunakeatbl[!,:λ], maunakeatbl[!,:Ext])

paranaltbl = ReadData("Paranal.dat")
paranaltbl.λ .= paranaltbl.λ.*u"angstrom"
paranalfnt = linear_interpolation(paranaltbl[!,:λ], paranaltbl[!,:Ext])

tololotbl = ReadData("CerroTololo.dat")
tololotbl.λ .= tololotbl.λ.*u"angstrom"
tololofnt = linear_interpolation(tololotbl[!,:λ], tololotbl[!,:Ext])


Recipes = Dict("Apache Point"=>apachefnt,"Cerro Paranal"=>paranalfnt, "Cerro Tololo"=>tololofnt, "Kitt Peak"=>kittfnt, "La Palma"=>lapalmafnt, "La Silla"=>lasillafnt, "Lick"=>lickfnt, "Mauna Kea"=>maunakeafnt)




end
