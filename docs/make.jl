using DMSPData
using Documenter
using DocumenterCitations

const name = "DMSPData.jl"
const bib = CitationBibliography(joinpath(@__DIR__, "$name.bib"))

DocMeta.setdocmeta!(DMSPData, :DocTestSetup, :(using DMSPData); recursive = true)

makedocs(;
    modules = [DMSPData],
    authors = "Zijin Zhang <zzj956959688@gmail.com> and contributors",
    sitename = name,
    format = Documenter.HTML(;
        canonical = "https://JuliaSpacePhysics.github.io/DMSPData.jl",
    ),
    warnonly = Documenter.except(:doctest, :example_block),
    pages = [
        "Home" => "index.md",
    ],
    plugins = [bib],
)

deploydocs(;
    repo = "github.com/JuliaSpacePhysics/DMSPData.jl",
    push_preview = true,
)
