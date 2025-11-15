using DMSPData
using Documenter

DocMeta.setdocmeta!(DMSPData, :DocTestSetup, :(using DMSPData); recursive=true)

makedocs(;
    modules=[DMSPData],
    authors="Beforerr <zzj956959688@gmail.com> and contributors",
    sitename="DMSPData.jl",
    format=Documenter.HTML(;
        canonical="https://JuliaSpacePhysics.github.io/DMSPData.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaSpacePhysics/DMSPData.jl",
    devbranch="main",
)
