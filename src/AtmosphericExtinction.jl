module AtmosphericExtinction


using CSV
using DataFrames
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
    extpath = joinpath("data",fname)
    if fname == "Paranal.dat"
        extdata = CSV.File(extpath; comment="#",header=["λ", "Ext", "eExt"])
    else
        extdata = CSV.File(extpath; comment="#",header=["λ", "Ext"])
    end
    exttbl = DataFrame(extdata)
    return exttbl
end


pachontbl = ReadData("CerroPachon.dat")
pachonfnt = linear_interpolation(pachontbl[!,:λ], pachontbl[!,:Ext], extrapolation_bc = NaN)

paranaltbl = ReadData("Paranal.dat")
paranalfnt = linear_interpolation(paranaltbl[!,:λ], paranaltbl[!,:Ext], extrapolation_bc = NaN)

lapalmatbl = ReadData("LaPalma.dat")
lapalmafnt = linear_interpolation(lapalmatbl[!,:λ], lapalmatbl[!,:Ext], extrapolation_bc = NaN)

lasillatbl = ReadData("LaSilla.dat")
lasillafnt = linear_interpolation(lasillatbl[!,:λ], lasillatbl[!,:Ext], extrapolation_bc = NaN)

maunakeatbl = ReadData("MaunaKea.dat")
maunakeafnt = linear_interpolation(maunakeatbl[!,:λ], maunakeatbl[!,:Ext], extrapolation_bc = NaN)


Recipes = Dict("Cerro Pachon"=>pachonfnt,"Cerro Paranal"=>paranalfnt, "La Palma"=>lapalmafnt, "La Silla"=>lasillafnt, "Mauna Kea"=>maunakeafnt)




end
