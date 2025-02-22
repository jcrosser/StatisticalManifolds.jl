function changeVariable(config::Configuration{N,V,P,O,T}, integrand, inplace,
    currProbability::BigFloat, weights, _weights,
    padding_probability, _padding_probability) where {N,V,P,O,T}
    # update to change the variables of the current diagrams
    maxdof = config.maxdof
    vi = rand(config.rng, 1:length(maxdof)) # update the variable type of the index vi
    var = config.var[vi]
    if (var isa Discrete) && (var.size == 1) # there is only one discrete element, there is nothing to sample with.
        return currProbability
    end
    if maxdof[vi] <= 0
        return currProbability
    end
    idx = var.offset + rand(config.rng, 1:maxdof[vi]) # randomly choose one var to update

    prop = Dist.shift!(var, idx, config)

    # sampler may want to reject, then prop has already been set to zero
    if prop <= eps(0.0)
        return currProbability
    end

    if inplace
        (fieldcount(V) == 1) ?
        integrand(config.var[1], _weights, config) :
        integrand(config.var, _weights, config)
    else
        _weights = (fieldcount(V) == 1) ?
                   integrand(config.var[1], config) :
                   integrand(config.var, config)
    end
    # evaulation acutally happens before this step
    config.neval += 1

    for i in 1:N+1
        _padding_probability[i] = Dist.padding_probability(config, i)
    end
    # Dist.padding_probability!(config, _padding_probability)
    # println(_padding_probability)
    newProbability = config.reweight[config.norm] * _padding_probability[config.norm] #normalization integral
    for i in 1:N #other integrals
        newProbability += abs(_weights[i]) * config.reweight[i] * _padding_probability[i]
    end
    R = prop * newProbability / currProbability

    config.propose[2, 1, vi] += 1.0
    if rand(config.rng) < R
        config.accept[2, 1, vi] += 1.0
        for i in 1:N # broadcast operator . doesn't work here, because _weights can be a scalar
            weights[i] = _weights[i]
        end
        for i in 1:N+1 # broadcast operator . doesn't work here, because _weights can be a scalar
            padding_probability[i] = _padding_probability[i]
        end
        # config.probability = newProbability
        return newProbability
    else
        Dist.shiftRollback!(var, idx, config)
        return currProbability
    end
    # return
end




function KL_testing(d1::T,d2::T;kwargs...) where {T<:Distribution} 
    P(x) = pdf(d1,x);Q(x) = pdf(d2,x);
    integrand(x) = Float64(log(10,P(big(x))/Q(big(x))));
    div = expectation(x->integrand(x),d1;kwargs...)
    return div
end