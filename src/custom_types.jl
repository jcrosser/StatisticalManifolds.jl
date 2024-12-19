### Declare custom types
## Abstract types
abstract type AbstractStatisticalManifold{ℝ} <: AbstractDecoratorManifold{ℝ} end

function active_traits(f,::AbstractStatisticalManifold,args...)
    return merge_traits(IsEmbeddedManifold(),IsDefaultMetric(FisherRaoMetric()))
end
## Create concrete instances of custom types]
struct StatisticalManifold <: AbstractStatisticalManifold{ℝ}
    model
    hypermodel
    StatisticalManifold(x,y) = (x >:Distribution)&(y >:Distribution) ? error("Arguments should be objects of type <:Distribution") : new(x,y)
end

 
struct Probability{T<:AbstractFloat} <: AbstractFloat 
    x::T
    function Probability(x::Number)
        if (x<0) || (x>1)
            throw(ArgumentError("x is $x but must be in the range [0, 1]"))
        end
        return new{typeof(x)}(x)
    end
end

### New Alias for structures in dependencies
const CountablyDiscreteDistribution = Union{
    Bernoulli,BernoulliLogit,BetaBinomial,Binomial,Categorical,Dirac,DiscreteUniform,
    Hypergeometric,PoissonBinomial,Soliton,Multinomial
}
const UncountablyDiscreteDistribution = Union{
    Geometric,NegativeBinomial,Poisson,Skellam
}

### Conversion functions
function (::Type{T})(x::Probability) where {T<:AbstractFloat}
    return convert(T,x.x)
end
function Base.promote_rule(::Type{T}, ::Type{Probability{S}}) where {T<:Number,S}
    return promote_type(T,S)
end