##### Dispatching function
expectation(f::Function,d::T;kwargs...) where {T} = expectation(supportstyle(T),f,d;kwargs...)
### Continuous distributions
function expectation(::Union{IsBounded,IsUnbounded},f,d;solver=HCubatureJL(),kwargs...)
    g = (x,p) -> f(x)*pdf(d,x)
    domain = extrema(d)
    problem = IntegralProblem(g,domain)
    expect = sovle(problem,solver;kwargs)
    return expect.x
end

### Discrete distributionsn
function expectation(::CountablyDiscreteDistribution,f,d;kwargs...)
    domain = support(d)
    expect = sum([f(i)*pdf(d,i) for i in domain])
    return expect
end

function expectation(::UncountablyDiscreteDistribution,f,d;kwargs...)
    domain = support(d)
    expect,_ = extrapolate(1,x0=Inf) do X
        sum(x -> f(x)*pdf(d,x), 1:Int(X))
    end
    return expect
end