#!/usr/bin/env julia
#
#

# Usa a small trick to have an own documenter environment but also always redner
# the docs that are in this base folders folder.
if Base.active_project() != joinpath(@__DIR__, "Project.toml")
    using Pkg
    Pkg.activate(@__DIR__)
    Pkg.develop(PackageSpec(; path=(@__DIR__) * "/../"))
    Pkg.resolve()
    Pkg.instantiate()
end

using StatisticalManifolds
using Documenter, DocumenterCitations, DocumenterInterLinks

bib = CitationBibliography(joinpath(@__DIR__, "src", "references.bib"); style=:alpha)
links = InterLinks(
    # Distributions seems to still render on a too old Documenter version
    # "Distributions.jl" => ("https://juliastats.github.io/Distributions.jl/stable/"),
    # Integrals seems to still render on a too old Documenter version
    # "Integrals.jl" => ("https://docs.sciml.ai/Integrals/stable/"),
    "ManifoldsBase" => ("https://juliamanifolds.github.io/ManifoldsBase.jl/stable/"),
    "Manifolds" => ("https://juliamanifolds.github.io/Manifolds.jl/stable/"),
    "Manopt" => ("https://manoptjl.org/stable/"),
    # MCIntegration seems to still render on a too old Documenter version
    #c"MCIntegration.jl" => ("https://numericaleft.github.io/MCIntegration.jl/stable/"),
)
makedocs(;
    modules=[StatisticalManifolds],
    authors="Jacob T. Crosser",
    #repo="https://github.com/jcrosser/StatisticalManifolds.jl/blob/{commit}{path}#{line}",
    sitename="StatisticalManifolds.jl",
    format=Documenter.HTML(; prettyurls=get(ENV, "CI", "false") == "true", assets=String[]),
    pages=["Home" => "index.md", "Literature" => "references.md"],
    plugins=[bib, links],
)

deploydocs(;
    repo="github.com/JuliaManifolds/StatisticalManifolds.jl.git",
    push_preview=true,
)
