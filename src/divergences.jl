function DSKL_Gauss(means1,covs1,means2,covs2)
    _,n=size(means1)
    C1 = ReconstructCov(covs1,n)
    invC1 = inv(C1)
    C2 = ReconstructCov(covs2,n)
    invC2 = inv(C2)
    dskl = (1/2)*(tr(invC1*C2)+tr(invC2*C1)+(means1-means2)'*(invC1+invC2)*(means1-means2)-2*n)
    return dskl
end
function D2I_Gauss(means1,covs1,means2,covs2)
    
    d2i = float(-8*log(sqrt(2*sqrt(C0*C1)/(C0+C1)))+2*(mu1-mu0)^2/(C1+C0))
    return d2i
end