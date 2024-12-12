### Declare custom types
## Abstract types
abstract type Manifold end

## Create concrete instances of custom types
struct StatisticalManifold <: Manifold end



### New Alias for structures in dependencies
const CountablyDiscreteDistribution = Union{
    Bernoulli,BernoulliLogit,BetaBinomial,Binomial,Categorical,Dirac,DiscreteUniform,
    Hypergeometric,PoissonBinomial,Soliton,Multinomial
}
const UncountablyDiscreteDistribution = Union{
    Geometric,NegativeBinomial,Poisson,Skellam
}
