# HDF5Dataset Usage Examples
using DMSPData.MadrigalHDF5Dataset
using Chairmarks

# Basic usage - similar to NCDataset
ds = HDF5Dataset("data/dms_20100109_16e.001.hdf5"; dims = ("timestamps", "ch_energy"))
ds.attrib
ds.dim[1]
var = ds["el_d_flux"]
hvar = ds.file["Data/Array Layout/2D Parameters/el_d_flux"]
@b ds["el_d_flux"]
# 24.301 ms (28 allocs: 20.594 MiB, 1.30% gc time)
@b Array(ds.file["Data"]["Array Layout"]["2D Parameters"]["el_d_flux"])
# Access variables by parameter name - much cleaner!
flux_data = ds["el_d_flux"]  # Automatically finds it in 2D Parameters
gdlat = ds["gdlat"]          # Automatically finds it in 1D Parameters

# # Variables are lazy - no data loaded yet
# println(typeof(flux_data))  # HDF5Variable{Float64,2}
# println(size(flux_data))    # Shows dimensions without loading

# # Indexing triggers lazy loading via DiskArrays
# subset = flux_data[1:100, :]  # Only loads requested slice
# point = flux_data[50, 10]     # Single element access

# # For chunked datasets, see chunk layout
# if DiskArrays.haschunks(flux_data) == DiskArrays.Chunked()
#     for chunk in DiskArrays.eachchunk(flux_data)
#         println("Chunk: ", chunk)
#     end
# end

# # Dictionary-like interface
# println(keys(ds))           # List all variables/groups
# println(haskey(ds, "Data")) # Check existence

# # Dot notation for convenience
# timestamps_alt = ds.Data."Array Layout".timestamps

# # Integration with DimensionalData
# using DimensionalData

# # Convert HDF5Variable to DimArray with metadata
# function to_dimarray(var::HDF5Variable, dims; metadata = Dict())
#     data = var[:]  # Load all data
#     return DimArray(data, dims; metadata, name = HDF5.name(var.dataset))
# end

# time_dim = Ti(unix2datetime.(ds["Data/Array Layout/timestamps"][:]))
# energy_dim = Y(ds["Data/Array Layout/ch_energy"][:])

# flux_dimarray = to_dimarray(
#     ds["Data/Array Layout/2D Parameters/el_d_flux"],
#     (time_dim, energy_dim);
#     metadata = Dict("units" => "1/cm²/s/sr/eV")
# )
