include("custom_types.jl")
function TsallisLog(x::Number;p::Probability{T})
    if p == 1.0
        y = log(x)
    else
        y = (x^(p-1) - 1)/(p*(1-p))
    end
    return y
end

### Old functions, prune
