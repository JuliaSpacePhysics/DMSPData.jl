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