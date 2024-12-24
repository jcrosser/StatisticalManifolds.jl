##### Dispatching function
expectation(f::Function,d::T;kwargs...) where {T} = _expectation(supportstyle(d),f,d;kwargs...)
### Continuous distributions
function _expectation(::Union{IsBounded,IsUnbounded},f,d;solver=HCubatureJL(),kwargs...)
    g = (x,p) -> f(x)*pdf(d,x)
    domain = extrema(d)
    problem = IntegralProblem(g,domain)
    expect = solve(problem,solver;kwargs...)
    return expect.u
end

### Discrete distributionsn
function _expectation(::IsCountable,f,d;kwargs...)
    domain = support(d)
    expect = sum([f(i)*pdf(d,i) for i in domain])
    return expect
end

function _expectation(::IsUncountable,f,d;kwargs...)
    domain = support(d)
    expect,_ = extrapolate(1,x0=Inf) do X
        sum(x -> f(x)*pdf(d,x), 1:Int(X))
    end
    return expect
end