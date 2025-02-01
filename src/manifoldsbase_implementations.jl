representation_size(M::StatisticalManifold) = (length(M.model),)
manifold_dimension(M::StatisticalManifold) = length(M.model)

## check_point function
# Dispatching functions
check_point(M::StatisticalManifold, x) = _check_point(typeof(M.model), M, x)
#check_point(M::StatisticalManifold, x) = _check_point(typeof(M.model),M,x)
### Implementations
function _check_point(::ContinuousDistribution, M, x)
    d = extrema(M.model)
    if any(x .< d[1]) || any(x .> d[2])
        throw(DomainError(x, "x is $x but must be in the range $d"))
    end
    return nothing
end
function _check_point(::DiscreteDistribution, M, x)
    d = support(M.model)
    if !(x in d)
        throw(DomainError(x, "x is $x but must be in the support $d"))
    end
    return nothing
end
