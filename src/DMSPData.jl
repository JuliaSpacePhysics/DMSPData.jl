module DMSPData

using Dates
using Dates: AbstractTime
using Madrigal
using DimensionalData
using GeoCotrans
using HDF5
using JLD2
export SSJ_Dataset

include("../lib/MadrigalHDF5Dataset/src/MadrigalHDF5Dataset.jl")

using .MadrigalHDF5Dataset

function SSJ_dataset_files(id, t0, t1)
    kindat = 10200 + id
    files = download_files(:dms, kindat, t0, t1)
    return unique!(sort!(files))
end

SSJ_dataset_files(id, timerange) = SSJ_dataset_files(id, timerange[1], timerange[2])

function SSJ_Dataset(id, t0, t1; verbose = false)
    files = SSJ_dataset_files(id, t0, t1)
    verbose && @info "Found $(length(files)) files" files
    return MFDataset(files, 1; dims = ("timestamps", "ch_energy"))
end

# Conform ISTP Metadata
const ssj_metadata_patch = Dict(
    "ch_energy" => Dict("SCALETYP" => log10, "LABLAXIS" => "Channel energy\n(eV)"),
    "el_d_ener" => Dict("SCALETYP" => log10, "z_range" => (1.0e5, 1.0e10), :yscale => log10),
    "el_i_ener" => Dict("SCALETYP" => log10, "LABLAXIS" => "Integr elect energy flux\n(eV/cm^2/s/sr)"),
    "el_m_ener" => Dict("SCALETYP" => log10, "LABLAXIS" => "Mean electron energy\n(eV)"),
    "ion_d_ener" => Dict("SCALETYP" => log10, "z_range" => (1.0e3, 1.0e8), :yscale => log10),
    "ion_i_ener" => Dict("SCALETYP" => log10, "LABLAXIS" => "Integr ion energy flux\n(eV/cm^2/s/sr)"),
    "ion_m_ener" => Dict("SCALETYP" => log10, "LABLAXIS" => "Mean ion energy\n(eV)"),
)

end
