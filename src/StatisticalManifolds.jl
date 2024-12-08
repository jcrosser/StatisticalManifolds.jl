__precompile__()
module StatisticalManifolds
### Load Major Dependencies
using Distributions, LinearAlgebra

### Import Minor Dependencies
#import

### Include all Pkg files

### Export user functions

### Initialize code 
function __init__()
    #copy!(sympy, PyCall.pyimport_conda("sympy", "sympy"))
end

### Declare custom types
abstract type Manifold end


## Create concrete instances of custom types
struct StatisticalManifold <: Manifold end


### Declare custom traits
## Abstract Trait Hierarchy
abstract type ModelStyle end

abstract type IsParametric <: ModelStyle end
abstract type IsNonParametric <: ModelStyle end

## Create concrete instances of traits
struct IsDataSample <: IsNonParametric end
struct IsSummaryStatistics <: IsNonParametric end

struct 

ModelStyle(::Type) = IsRawData()
ModelStyle(::Type{<:Distribution}) = IsParametric()



# Write your package code here.

end
