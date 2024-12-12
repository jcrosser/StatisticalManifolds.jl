### Continuous distributions
function expectation(f::function,d<:ContinuousDistribution;solver=HCubatureJL(),kwargs...)
    g = (x,p) -> f(x)*pdf(d,x)
    domain = extrema(d)
    problem = IntegralProblem(g,domain)
    sol = sovle(problem,solver;kwargs)
    return sol.x
end

### Discrete distributionsn
function expectation(f::function,d<:DiscreteDistribution)
    f = (x,p) -> f(x)*pdf(d,x)
end