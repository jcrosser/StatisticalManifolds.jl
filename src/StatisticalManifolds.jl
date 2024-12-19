__precompile__()
module StatisticalManifolds
### Load Major Dependencies
using Manifolds
using Distributions, LinearAlgebra, StatsModels#, StatsBase ##Core Utils dependencies
using Integrals, Richardson, ForwardDiff  ## Method Util dependencies for expectations 
using MultivariateStats ## Util dependency for PCA/MDS

### Import Minor Dependencies
#import

### Include all Pkg files
include("divergences.jl")
include("array_functions.jl")
include("custom_types.jl")
include("custom_traits.jl")
include("assorted_functions.jl")
### Export user functions

### Initialize code 
function __init__()
    
end





# Write your package code here.

end
