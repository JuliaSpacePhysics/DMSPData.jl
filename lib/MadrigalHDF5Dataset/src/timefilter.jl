using MappedArrays

_times(x) = eltype(x) == Float64 ? mappedarray(unix2datetime, x) : x

"""
    prepare_time_indices(times, timerange)

Find indices corresponding to a timerange in a sorted `timestamps` vector.
Returns `nothing` if no filtering needed, or a UnitRange of indices.
"""
function prepare_time_indices(times, timerange)
    # No filtering requested
    isnothing(timerange) && return nothing
    if !issorted(times)
        @warn "Times not sorted, cannot efficiently filter by timerange. Reading full dataset."
        return nothing
    end
    T = eltype(times)
    idx1 = searchsortedfirst(times, T(timerange[1]))
    idx2 = searchsortedlast(times, T(timerange[2]))
    return idx1:idx2
end

function _read(dset, idxs)
    return if HDF5.iscontiguous(dset)
        fdata = HDF5.readmmap(dset)
        Array(selectdim(fdata, 1, idxs))
    else
        fdata = read(dset)
        selectdim(fdata, 1, idxs)
    end
end


struct TimeFilteredHDF5Dataset{DS, TR, TS, I} <: AbstractDataset
    dataset::DS
    timerange::TR
    _times::TS
    _time_indices::I
end

function TimeFilteredHDF5Dataset(ds, timerange)
    times = ds.dim[1]
    time_indices = prepare_time_indices(times, timerange)
    return TimeFilteredHDF5Dataset(ds, timerange, times, time_indices)
end
TimeFilteredHDF5Dataset(path::AbstractString, timerange; kw...) = TimeFilteredHDF5Dataset(HDF5Dataset(path; kw...), timerange)

_dataset(ds::TimeFilteredHDF5Dataset) = ds.dataset
function dim(ds::TimeFilteredHDF5Dataset, i)
    return if i == 1
        ds._times[ds._time_indices]
    else
        dim(ds.dataset, i)
    end
end

function Base.getindex(ds::TimeFilteredHDF5Dataset, name)
    return if has_array_layout(ds)
        array_layout_getindex(ds.dataset, name, ds._time_indices)
    elseif has_table_layout(ds)
        table_layout_getindex(ds.dataset, name)
    else
        ds.dataset.file[name]
    end
end

traits(ds) = traits(_dataset(ds))
