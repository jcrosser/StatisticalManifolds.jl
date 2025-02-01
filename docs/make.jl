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
using Documenter

makedocs(;
    modules=[StatisticalManifolds],
    authors="Jacob T. Crosser",
    #repo="https://github.com/jcrosser/StatisticalManifolds.jl/blob/{commit}{path}#{line}",
    sitename="StatisticalManifolds.jl",
    format=Documenter.HTML(; prettyurls=get(ENV, "CI", "false") == "true", assets=String[]),
    pages=["Home" => "index.md"],
)

deploydocs(;
    repo="github.com/JuliaManifolds/StatisticalManifolds.jl.git",
    push_preview=true,
)
