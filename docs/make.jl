using JuliaHashcode
using Documenter

DocMeta.setdocmeta!(JuliaHashcode, :DocTestSetup, :(using JuliaHashcode); recursive=true)

makedocs(;
    modules=[JuliaHashcode],
    authors="Shawn Monel <smonel@mit.edu> and contributors",
    repo="https://github.com/smonel12/JuliaHashcode.jl/blob/{commit}{path}#{line}",
    sitename="JuliaHashcode.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://smonel12.github.io/JuliaHashcode.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/smonel12/JuliaHashcode.jl",
    devbranch="main",
)
