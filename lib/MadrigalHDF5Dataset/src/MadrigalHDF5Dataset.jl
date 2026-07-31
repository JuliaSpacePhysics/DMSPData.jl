module MadrigalHDF5Dataset
using HDF5
using FieldViews: FieldViewable
using Dates

export HDF5Dataset, MFDataset

struct Dimensions{P}
    parentdataset::P
end

Base.getindex(D::Dimensions, i) = dim(D.parentdataset, i)

struct HDF5Variable{T, N, P, A <: AbstractArray{T, N}} <: AbstractArray{T, N}
    data::A
    name::String
    parentdataset::P
end

Base.parent(dataset::HDF5Variable) = dataset.data
Base.size(dataset::HDF5Variable) = size(dataset.data)
Base.getindex(dataset::HDF5Variable, I...) = dataset.data[I...]
Base.setindex!(dataset::HDF5Variable, X, I...) = setindex!(dataset.data, X, I...)

@inline function Base.getproperty(var::HDF5Variable, name::Symbol)
    name in fieldnames(HDF5Variable) && return getfield(var, name)
    name == :attrib && return data_params(var.parentdataset, var.name)
end

include("hdf5dataset.jl")
include("multifile.jl")
include("timefilter.jl")
include("../ext/HDF5DimensionalData.jl")

end
