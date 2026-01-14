using AtmosphericExtinction
using Test

@testset "AtmosphericExtinction.jl" begin
    # Cerro Pachon
    @test Recipes["Cerro Pachon"](3500:3502) == [0.44, 0.4393, 0.4386]
    #
    # Cerro Paranal
    @test Recipes["Cerro Paranal"](3500:3502) == [0.539, 0.5384800000000001, 0.53796]
    #
    # La Palma
    @test Recipes["La Palma"](3500:3502) == [0.5146, 0.513968, 0.5133359999999999]
    #
    # La Silla
    @test Recipes["La Silla"](3500:3502) == [0.52, 0.5194000000000001, 0.5188]
    #
    # Mauna Kea
    @test Recipes["Mauna Kea"](3500:3502) == [0.44, 0.4393, 0.4386]
    #
end
