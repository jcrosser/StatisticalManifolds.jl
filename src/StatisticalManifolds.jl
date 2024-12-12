__precompile__()
module StatisticalManifolds
### Load Major Dependencies
using Distributions, LinearAlgebra, StatsModels#, StatsBase
using Integrals # Workhorse for expectation.jl

### Import Minor Dependencies
#import

### Include all Pkg files
include("divergences.jl");include("assorted_functions.jl");include("array_functions.jl");
include("custom_types.jl");include("custom_traits.jl")
### Export user functions

### Initialize code 
function __init__()
    #copy!(sympy, PyCall.pyimport_conda("sympy", "sympy"))
end





# Write your package code here.

end
