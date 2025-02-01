### Numerical implementations
function divergence(
    d1::T,
    d2::T,
    divtype::Function="symmKL";
    kwargs...,
) where {T<:Distribution}
    return divtype(d1, d2, type; kwargs...)
end
function KL(d1::T, d2::T; kwargs...) where {T<:Distribution}
    P(x) = pdf(d1, x)
    Q(x) = pdf(d2, x)
    integrand(x) = log(10, P(x) / Q(x))
    div = expectation(integrand, d1; kwargs...)
    return div
end
function symmKL(d1::T, d2::T; kwargs...) where {T<:Distribution}
    P(x) = pdf(d1, x)
    Q(x) = pdf(d2, x)
    integrand1(x) = log(10, P(x) / Q(x))
    integrand2(x) = log(10, Q(x) / P(x))
    div = expectation(integrand1, d1; kwargs...) + expectation(integrand2, d2; kwargs...)
    return div
end
function TsallisKL(d1::T, d2::T; q::AbstractFloat=1, kwargs...) where {T<:Distribution}
    P(x) = pdf(d1, x)
    Q(x) = pdf(d2, x)
    integrand(x) = TsallisLog(P(x) / Q(x), p=Probability(q))
    div = expectation(integrand, d1; kwargs...)
    return div
end
function Renyi(d1::T, d2::T; beta::Real=0.5, kwargs...) where {T<:Distribution}
    P(x) = pdf(d1, x)
    Q(x) = pdf(d2, x)
    integrand = (P(x) * Q(x))^(beta - 1)
    if (beta < 0) || (beta == 1)
        throw(ArgumentError("beta is $(beta) but must be in the range (0, 1)∪(1, ∞)"))
    end
    div = log(expectation(integrand, d1; kwargs...)) / (1 - beta)
    return div
end
function JS(d1::T, d2::T; kwargs...) where {T<:Distribution}
    P(x) = pdf(d1, x)
    Q(x) = pdf(d2, x)
    M(x) = (P(x) + Q(x)) / 2
    integrand1 = log(10, P(x) / M(x))
    integrand2 = log(10, Q(x) / M(x))
    div = expectation(integrand1, d1; kwargs...) + expectation(integrand2, d2; kwargs...)
    return div
end
function Bregman(d1::T, d2::T; f::Function, difference::Function) where {T<:Distribution}
    theta1 = params(d1)
    theta2 = params(d2)
    Gradf(x) = ForwardDiff.gradient(f, x)
    div = f(theta1) - f(theta2) - difference(theta1, theta2) .* Gradf(theta2)
    return div
end
