using AtmosphericExtinction
using Documenter



DocMeta.setdocmeta!(AtmosphericExtinction, :DocTestSetup, :(using AtmosphericExtinction); recursive=true)



makedocs(;
    modules=[AtmosphericExtinction],
    authors="Stefano Covino <stefano.covino@inaf.it> and contributors",
    sitename="AtmosphericExtinction.jl",
    format=Documenter.HTML(;
        canonical="https://stefanocovino.github.io/AtmosphericExtinction.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/stefanocovino/AtmosphericExtinction.jl",
    devbranch="main",
)
