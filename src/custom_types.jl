### Declare custom types
## Abstract types
abstract type AbstractStatisticalManifold{ℝ} <: AbstractDecoratorManifold{ℝ} end
abstract type AbstractStatisticalModel end#<: Distribution end

function active_traits(f, ::AbstractStatisticalManifold, args...)
    return merge_traits(IsEmbeddedManifold(), IsDefaultMetric(FisherRaoMetric()))
end
## Create concrete instances of custom types]
struct StatisticalModel <: AbstractStatisticalModel
    callable_distribution::Function
    natural_parameter_manifold::AbstractManifold
    parameterdimension::Int
    nullarg
    function StatisticalModel(D, M, pd, N)
        return !(typeof(D(N)) <: Distribution) ?
               error(
            "Model function evaluated at the null argument should be an object of type <:Distribution",
        ) : new(D, M, pd, N)
    end
end

struct StatisticalManifold <: AbstractStatisticalManifold{ℝ}
    model::StatisticalModel
    hypermodel::Distribution
    parametermap
    function StatisticalManifold(x, y, z)
        return !(x <: StatisticalModel) || !(y <: Distribution) ?
               error("Arguments should be objects of type <:Distribution") : new(x, y, z)
    end
end

struct Probability{T<:AbstractFloat} <: AbstractFloat
    x::T
    function Probability(x::Number)
        if (x < 0) || (x > 1)
            throw(ArgumentError("x is $x but must be in the range [0, 1]"))
        end
        return new{typeof(x)}(x)
    end
end

### Outer constructor methods
function StatisticalModel(D::Function, M::AbstractManifold, nullarg)
    return StatisticalModel(D, M, length(nullarg), nullarg)
end

### New Alias for structures in dependencies
const CountablyDiscreteDistribution = Union{
    Bernoulli,
    BernoulliLogit,
    BetaBinomial,
    Binomial,
    Categorical,
    Dirac,
    DiscreteUniform,
    Hypergeometric,
    PoissonBinomial,
    Soliton,
    Multinomial,
}
const UncountablyDiscreteDistribution = Union{Geometric,NegativeBinomial,Poisson,Skellam}
const PDFDistribution =
    Union{UnivariateDistribution,MatrixDistribution,UnivariateMixture,MultivariateMixture}
const LogLikelihoodDistribution = MultivariateDistribution
### Conversion functions
function (::Type{T})(x::Probability) where {T<:AbstractFloat}
    return convert(T, x.x)
end
function Base.promote_rule(::Type{T}, ::Type{Probability{S}}) where {T<:Number,S}
    return promote_type(T, S)
end
