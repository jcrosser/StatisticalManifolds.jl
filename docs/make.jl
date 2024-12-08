using StatisticalManifolds
using Documenter

DocMeta.setdocmeta!(StatisticalManifolds, :DocTestSetup, :(using StatisticalManifolds); recursive=true)

makedocs(;
    modules=[StatisticalManifolds],
    authors="Jacob T. Crosser",
    repo="https://github.com/Owner/StatisticalManifolds.jl/blob/{commit}{path}#{line}",
    sitename="StatisticalManifolds.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Owner.github.io/StatisticalManifolds.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Owner/StatisticalManifolds.jl",
    devbranch="master",
)
