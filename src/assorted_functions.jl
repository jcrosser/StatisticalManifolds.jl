function creategrid(iters)
    d = length(iters)
    iter = Iterators.product((iters[i] for i in 1:d)...)
    return transpose(reduce(hcat,vec([collect(i) for i in iter])))
end
function LogNormalGridMaker(iters,means,sigmas)
    grid = creategrid(iters)
    _,d = size(grid)
    return reduce(hcat,[InvLNCDF.(grid[:,i],means[i],sigmas[i]) for i =1:d])
end
function InvLNCDF(x,mu,sig)
    u = exp(mu+sig*sqrt(2)*SpecialFunctions.erfinv(2x-1))
    return u
end
function EI_ratio(W_lin,row_index)
    W_row = W_lin[row_index,:]
    return sum(W_row[W_row.>0])/abs.(sum(W_row[W_row.<0]))
end
function Hyperbolic_ParticipationRatio(eigvals)
    return (sum(abs.(eigvals)))^2/(sum(eigvals.^2))
end
function Check_EI_balance(W,input_rates)
    check = 1
    if LinearAlgebra.det(W)== 0
        check = 0
    elseif any(x->x<0,(W\input_rates))
        check = 0
    end
    return check
end
function dfRowToVec(dfrow)
    return [dfrow[i] for i = 1:length(dfrow)]
end
function MakeWFull(W_reduced,Ns,Ps)
    nblocks = length(Ns)
    W = []
    for i = 1:nblocks
        row = []
        for j = 1:nblocks
            if j == 1
                row = W_reduced[i,j]*float.(rand(Distributions.Bernoulli(Ps[j]),Ns[i],Ns[j]))
            else
                row = [row W_reduced[i,j]*float.(rand(Distributions.Bernoulli(Ps[j]),Ns[i],Ns[j]))]
            end
        end
        if i == 1
            W = row
        else
            W = [W; row]
        end
    end
    return W
end