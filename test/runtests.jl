using AtmosphericExtinction
using Test
using Unitful

@testset "AtmosphericExtinction.jl" begin
    #
    wlrng = 3500*u"angstrom":1*u"angstrom":3502*u"angstrom"
    #
    # Cerro Paranal
    @test Recipes["Cerro Paranal"](wlrng) == [0.539, 0.5384800000000001, 0.53796]
    #
    # La Palma
    @test Recipes["La Palma"](wlrng) == [0.5146, 0.513968, 0.5133359999999999]
    #
    # La Silla
    @test Recipes["La Silla"](wlrng) == [0.52, 0.5194000000000001, 0.5188]
    #
    # Mauna Kea
    @test Recipes["Mauna Kea"](wlrng) == [0.44, 0.4393, 0.4386]
    #
    # Apache Point
    @test Recipes["Apache Point"](wlrng) == [0.540046, 0.5389448, 0.5378436]
    #
    # Cerro Tololo
    @test Recipes["Cerro Tololo"](wlrng) == [0.62, 0.6192957746478873, 0.6185915492957746]
    #
    # Kitt Peak
    @test Recipes["Kitt Peak"](wlrng) == [0.6, 0.5993802816901408, 0.5987605633802817]
    #
    # Lick
    @test isapprox(Recipes["Lick"](wlrng),[0.665, 0.6643239436619719, 0.66364788732394387],rtol=1e-4)
    #
end
