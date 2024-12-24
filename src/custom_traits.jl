### Declare custom traits
## Abstract Trait Hierarchy 
abstract type SupportStyle end
## Create concrete instances of traits
struct IsBounded <: SupportStyle end
struct IsUnbounded <: SupportStyle end

struct IsCountable <: SupportStyle end
struct IsUncountable <: SupportStyle end

## Trait ID

function SupportStyle(::Type{<:ContinuousDistribution})
    domain = extrema(d)
    if any(x->abs(x) == Inf,domain[1])||any(x->abs(x) == Inf,domain[2])
        out = IsUnbounded()
    else
        out = IsBounded()
    end
end
SupportStyle(::Type{<:CountablyDiscreteDistribution}) = IsCountable()
SupportStyle(::Type{<:UncountablyDiscreteDistribution}) = IsUncountable()
#SupportStyle(::Type) = IsBounded()
## Implementation



