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
apachefnt = linear_interpolation(apachetbl[!,:λ], apachetbl[!,:Ext], extrapolation_bc = NaN)

pachontbl = ReadData("CerroPachon.dat")
pachonfnt = linear_interpolation(pachontbl[!,:λ], pachontbl[!,:Ext], extrapolation_bc = NaN)

kitttbl = ReadData("KittPeak.dat")
kittfnt = linear_interpolation(kitttbl[!,:λ], kitttbl[!,:Ext], extrapolation_bc = NaN)

lapalmatbl = ReadData("LaPalma.dat")
lapalmafnt = linear_interpolation(lapalmatbl[!,:λ], lapalmatbl[!,:Ext], extrapolation_bc = NaN)

lasillatbl = ReadData("LaSilla.dat")
lasillafnt = linear_interpolation(lasillatbl[!,:λ], lasillatbl[!,:Ext], extrapolation_bc = NaN)

licktbl = ReadData("Lick.dat")
lickfnt = linear_interpolation(licktbl[!,:λ], licktbl[!,:Ext], extrapolation_bc = NaN)

maunakeatbl = ReadData("MaunaKea.dat")
maunakeafnt = linear_interpolation(maunakeatbl[!,:λ], maunakeatbl[!,:Ext], extrapolation_bc = NaN)

paranaltbl = ReadData("Paranal.dat")
paranalfnt = linear_interpolation(paranaltbl[!,:λ], paranaltbl[!,:Ext], extrapolation_bc = NaN)

tololotbl = ReadData("CerroTololo.dat")
tololofnt = linear_interpolation(tololotbl[!,:λ], tololotbl[!,:Ext], extrapolation_bc = NaN)


Recipes = Dict("Apache Point"=>apachefnt,"Cerro Pachon"=>pachonfnt,"Cerro Paranal"=>paranalfnt, "Cerro Tololo"=>tololofnt, "Kitt Peak"=>kittfnt, "La Palma"=>lapalmafnt, "La Silla"=>lasillafnt, "Lick"=>lickfnt, "Mauna Kea"=>maunakeafnt)




end
