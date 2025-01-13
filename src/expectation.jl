##### Dispatching function
@doc raw"""
    expectation(f::Function,d::Distribution;kwargs...) 

Numerically evaluate the expectation of `f(x)` against the probability density (mass) function `p(x|\theta)` over domain `\mathcal{D}` for distribution `d`

```math
\mathbb{E} := \int_{\mathca{D}}dx\, f(x)p(x|\theta)\,\,\,\text{Continuous}\\
\mathbb{E} := \sum_{x\in\mathca{D}} f(x)p(x|\theta)\,\,\,\text{Discrete}}
```

This function acts as an interface between distriubtion obects from [`Distributions.jl`](@extref `Distributions.jl`) and the numerical methods from ['Integrals.jl`](@extref `Integrals.jl`)
and [`MCIntegration.jl`](@extref `MCIntegration.jl`) for continuous distributions and [`Richardson.jl`](@extref `Richardson.jl`) for discrete distributions with an infinite domain.
"""
expectation(f::Function,d::T;kwargs...) where {T} = _expectation(SupportStyle(typeof(d),d),f,d;kwargs...)

### Implementations
function _expectation(::Union{IsBounded,IsUnbounded},f,d;solver=HCubatureJL(),kwargs...)
    g = (x,p) -> f(x)*pdf(d,x)
    domain = extrema(d)
    problem = IntegralProblem(g,domain)
    expect = solve(problem,solver;kwargs...)
    return expect.u
end
function _expectation(::IsCountable,f,d;kwargs...)
    domain = support(d)
    expect = sum([f(i)*pdf(d,i) for i in domain])
    return expect
end

function _expectation(::IsUncountable,f,d;kwargs...)
    #domain = support(d)
    expect,_ = extrapolate(1,x0=Inf) do X
        sum(x -> f(x)*pdf(d,x), 1:Int(X))
    end
    return expect
end