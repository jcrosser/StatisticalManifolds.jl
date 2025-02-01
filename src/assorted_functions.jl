function TsallisLog(x::Number; p::Probability)
    if p == 1.0
        y = log(x)
    else
        y = (x^(p - 1) - 1) / (p * (1 - p))
    end
    return y
end

### Old functions, prune
