function find_ranges(array)
    l=length(array[1,:])
    ranges=zeros(2,l)
    ranges[1,:]=[minimum(array[:,i]) for i=1:l]
    ranges[2,:]=[maximum(array[:,i]) for i=1:l]
    return ranges
end
function rank_entries(array)
    l=length(array)
    ranks=zeros(l)
    arr_copy=copy(array)
    for i=1:l
        nextmax=findfirst(x->x==maximum(arr_copy),arr_copy)
        ranks[nextmax]=Int(l+1-i)
        arr_copy[nextmax]=-Inf
    end
    return ranks
end
function rank_sort(array,ranks,dim)
    sorted = zeros(size(array))
    l=length(ranks)
    arr_dim = ndims(array)
    if dim==1
    if arr_dim==1
    for i=1:l
    sorted[l+1-i,:]=array[findall(x->x==i,ranks)]
    end
    else
    for i=1:l
    sorted[l+1-i,:]=array[findall(x->x==i,ranks),:]
    end
    end
    else
    for i=1:l
    sorted[:,l+1-i]=array[:,findall(x->x==i,ranks)]
    end
    end
    return sorted
end
function rank_sort_str(array,ranks)
    sorted = []
    l=length(ranks)
    for i=1:l
    append!(sorted,array[findall(x->x==l+1-i,ranks)])
    end
    return sorted
end
function remove_cols(array,ordered_inds)
    array_copy = array
    l=length(ordered_inds)
    dim_arr=ndims(array)
    if dim_arr==1
    n=length(array)
    for i=1:l
    n = length(array_copy)
    array_copy = array_copy[1:n.!=ordered_inds[l+1-i]]
    end
    else
    _,n=size(array)
    for i=1:l
    _,n=size(array_copy)
    array_copy=array_copy[:,1:n.!=ordered_inds[l+1-i]]
    end
    end
    return array_copy
end