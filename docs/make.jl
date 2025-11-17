using DMSPData
using Documenter

DocMeta.setdocmeta!(DMSPData, :DocTestSetup, :(using DMSPData); recursive=true)

makedocs(;
    modules=[DMSPData],
    authors="Zijin Zhang <zzj956959688@gmail.com> and contributors",
    sitename="DMSPData.jl",
    format=Documenter.HTML(;
        canonical="https://JuliaSpacePhysics.github.io/DMSPData.jl",
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaSpacePhysics/DMSPData.jl",
)
