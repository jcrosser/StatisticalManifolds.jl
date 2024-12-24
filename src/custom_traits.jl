### Declare custom traits
## Abstract Trait Hierarchy 
abstract type SupportStyle end
## Create concrete instances of traits
struct IsBounded <: SupportStyle end
struct IsUnbounded <: SupportStyle end

struct IsCountable <: SupportStyle end
struct IsUncountable <: SupportStyle end

## Implementation
supportstyle(d::T) where {T} = _supportstyle(typeof(d),d)
#_supportstyle(::Type,d) = undef
function _supportstyle(::Type{T},d::T) where {T<:ContinuousDistribution}
    domain = extrema(d)
    if any(x->abs(x) == Inf,domain[1])||any(x->abs(x) == Inf,domain[2])
        out = IsUnbounded()
    else
        out = IsBounded()
    end
end 
_supportstyle(::Type{T},d) where {T<:CountablyDiscreteDistribution} = IsCountable()
_supportstyle(::Type{T},d) where {T<:UncountablyDiscreteDistribution} = IsUncountable()


