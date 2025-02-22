function TsallisLog(x::Number;p::Probability)
    if p == 1.0
        y = log(x)
    else
        y = (x^(p-1) - 1)/(p*(p-1))
    end
    return y
end

### Old functions, prune
