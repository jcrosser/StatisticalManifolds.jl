##### Dispatching function
@doc raw"""
    expectation(f::Function,d::Distribution;kwargs...)

Numerically evaluate the expectation of `f(x)` against the probability density (mass) function `p(x|\theta)` over domain `\mathcal{D}` for distribution `d`

```math
\mathbb{E} := \int_{\mathca{D}}dx\, f(x)p(x|\theta)\,\,\,\text{Continuous}\\
\mathbb{E} := \sum_{x\in\mathca{D}} f(x)p(x|\theta)\,\,\,\text{Discrete}}
```

This function acts as an interface between distriubtion obects from [`Distributions.jl`](https://juliastats.github.io/Distributions.jl/stable/) and the numerical methods from ['Integrals.jl`](https://docs.sciml.ai/Integrals/stable/)
and [`MCIntegration.jl`](https://numericaleft.github.io/MCIntegration.jl/stable/) for continuous distributions and [`Richardson.jl`](https://github.com/JuliaMath/Richardson.jl) for discrete distributions with an infinite domain.
"""
expectation(f::Function, d::T; kwargs...) where {T} =
    _expectation(SupportStyle(typeof(d), d), f, d; kwargs...)

### Implementations
function _expectation(::Union{IsBounded,IsUnbounded}, f, d; solver=HCubatureJL(), kwargs...)
    g = (x, p) -> f(x) * pdf(d, x)
    domain = extrema(d)
    problem = IntegralProblem(g, domain)
    expect = solve(problem, solver; kwargs...)
    println(domain)
    println(problem)
    println(expect)
    return expect.u
end
function _expectation(::IsCountable, f, d; kwargs...)
    domain = support(d)
    expect = sum([f(i) * pdf(d, i) for i in domain])
    return expect
end

function _expectation(::IsUncountable, f, d; kwargs...)
    #domain = support(d)
    expect, _ = extrapolate(1, x0=Inf) do X
        return sum(x -> f(x) * pdf(d, x), 1:Int(X))
    end
    return expect
end
