using DimensionalData
using DimensionalData.Dimensions
using DimensionalData: NoMetadata
import DimensionalData: DimStack, DimArray

name(d) = nothing
name(v::HDF5Variable) = v.name

_dict(d) = d
_dict(nt::NamedTuple) = Dict(pairs(nt))

function DimensionalData.DimStack(ds::MFDataset, params = keys(ds); data_params = NoMetadata())
    _dims = (ds.dim[1], ds.dim[2])
    dims = (Ti(_dims[1]), Y(_dims[2]; metadata = get(data_params, name(_dims[2]), NoMetadata())))
    das = map(params) do param
        data = ds[param]
        metadata = get(data_params, param, NoMetadata())
        DimArray(data, dims[1:ndims(data)]; name = param, metadata)
    end
    return DimStack(das)
end

function DimensionalData.DimArray(var::HDF5Variable)
    _dims = (var.parentdataset.dim[1], var.parentdataset.dim[2])
    dims = (Ti(_dims[1]), Y(_dims[2]))
    return DimArray(var.data, dims[1:ndims(var)]; name = var.name, metadata = _dict(var.attrib))
end
