
module StatisticalManifolds
__precompile__()
### Load Major Dependencies
using Manifolds,ManifoldsBase
using Distributions, LinearAlgebra, StatsModels#, StatsBase ##Core Utils dependencies
using Integrals, MCIntegration, Richardson, ForwardDiff  ## Method Util dependencies for expectations 
using MultivariateStats ## Util dependency for PCA/MDS

### Import Minor Dependencies
import ManifoldsBase: 
    representation_size,
    manifold_dimension,
    check_point
import Distributions:
    ContinuousUnivariateDistribution,
    ContinuousMultivariateDistribution,
    ContinuousDistribution,
    DiscreteDistribution,
    DiscreteUnivariateDistribution,
    DiscreteMultivariateDistribution,
    PDFDistribution,
    LogLikelihoodDistribution
#import Integrals:

#import MCIntegration:

#import Richardson:

### Include all Pkg files
include("divergences.jl");include("array_functions.jl");include("custom_types.jl");include("custom_traits.jl");
include("assorted_functions.jl");include("expectation.jl");include("metrics.jl");include("manifoldsbase_implementations.jl");
### Export types and traits
export StatisticalManifold, AbstractStatisticalManifold, Probability
### Export divergence functions
export TsallisKL_divergence,
    KL_divergence,
    symmKL_divergence,
    Renyi_divergence,
    JS_divergence,
    Bregman_divergence
### Export other functions for external use
export TsallisLog,
    expectation,
    supportstyle
### Initialize code 
function __init__()
    
end





# Write your package code here.

end
