module DMSPData

using Dates
using Dates: AbstractTime
using Madrigal
using DimensionalData
using HDF5
export SSJ_Dataset, S1_Dataset, S4_Dataset

include("../lib/MadrigalHDF5Dataset/src/MadrigalHDF5Dataset.jl")

using .MadrigalHDF5Dataset

function SSJ_dataset_files(id, t0, t1)
    kindat = 10200 + id
    files = download_files(:dms, kindat, t0, t1)
    return unique!(sort!(files))
end

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

function S1_data_files(id, t0, t1)
    kindat = 10100 + id
    files = download_files(:dms, kindat, t0, t1)
    return unique!(sort!(files))
end

function S1_Dataset(id, t0, t1; verbose = false)
    files = S1_data_files(id, t0, t1)
    verbose && @info "Found $(length(files)) files" files
    return MFDataset(files, 1)
end

function S4_data_files(id, t0, t1)
    kindat = 10130 + id
    files = download_files(:dms, kindat, t0, t1)
    return unique!(sort!(files))
end

function S4_Dataset(id, t0, t1; verbose = false)
    files = S4_data_files(id, t0, t1)
    verbose && @info "Found $(length(files)) files" files
    return MFDataset(files, 1)
end

const s1_metadata_patch = Dict(
    "ne" => Dict("LABLAXIS" => "Electron density\n(m^-3)"),
    "vert_ion_v" => Dict("LABLAXIS" => "Vertical ion velocity\n(m/s)"), # (pos=Down)
    "hor_ion_v" => Dict("LABLAXIS" => "Horizontal ion velocity\n(m/s)"), # (pos=sunward)
)

const s4_metadata_patch = Dict(
    "ti" => Dict("LABLAXIS" => "Ion temperature\n(K)"),
    "te" => Dict("LABLAXIS" => "Electron temperature\n(K)"),
    "po+" => Dict("LABLAXIS" => "Composition - [O+]/Ne"),
    "elepot" => Dict("LABLAXIS" => "Electron potential (V)"),
)

end
