```@meta
CurrentModule = DMSPData
```

# DMSPData.jl

[![DOI](https://zenodo.org/badge/1096784690.svg)](https://doi.org/10.5281/zenodo.17946429)
[![version](https://juliahub.com/docs/General/DMSPData/stable/version.svg)](https://juliahub.com/ui/Packages/General/DMSPData)

Access and process [Defense Meteorological Satellite Program](https://www.wikipedia.org/wiki/Defense_Meteorological_Satellite_Program) (DMSP) data.

```@index
```

## Installation

```julia
using Pkg
Pkg.add("DMSPData")
```

## Madrigal

8100 is the instrument ID for DMSP in [Madrigal database](https://cedar.openmadrigal.org/instMetadata).

```@example quicklook
using DMSPData
using DMSPData.Madrigal
using Dates

t0 = DateTime("2010-01-10T00:04")
t1 = DateTime("2010-01-10T00:35")


kinst = 8100
get_experiments(kinst, t0, t1)
get_instrument_files(kinst, t0, t1)
```

## Quicklook

Here we reproduce the figure 3 in [F16 10 January 2010 first auroral crossing of the day](https://doi.org/10.1029/2009JA014362) ([redmonNewDMSPDatabase2017](@citet)).

```@example quicklook
s1_ds = S1_Dataset(16, t0, t1)
s4_ds = S4_Dataset(16, t0, t1)
ssj_ds = SSJ_Dataset(16, t0, t1)
```

```@example quicklook
using DimensionalData
using CairoMakie, SpacePhysicsMakie

vars = ("el_d_ener", "el_i_ener", "el_m_ener", "ion_d_ener", "ion_i_ener", "ion_m_ener", "mlat")
ds = DimStack(ssj_ds, vars; data_params = DMSPData.ssj_metadata_patch)
for A in (ds.el_d_ener, ds.ion_d_ener)
    A[A .< 1e3] .= NaN
end
let colormap = :turbo, f = Figure(; size = (1200, 1000))
    faxs = tplot(f, ds; colormap)
    ylims!(faxs.axes[2], 1e9, 1e13)
    ylims!(faxs.axes[5], 1e9, 1e13)
    f
end
```

> F16 10 January 2010 first auroral crossing of the day. (a) Background adjusted electron differential energy flux (jE) (eV/cm2 sr ΔeV s), (b) integrated electron energy flux (JE) (eV/cm2 sr s), (c) average electron energy (Eavg) (eV), (d–f) same quantities for ions, and (g) AACGM latitude and MLT (right y axis).  - [redmonNewDMSPDatabase2017](@citet)

## Calculations

```@example quicklook
# Computing magnetic field coordinates
# L-shell, MLT, Blocal, Bmin, Lstar, and XJ
# See https://juliaspacephysics.github.io/IRBEM.jl/dev/#Computing-magnetic-field-coordinates
using IRBEM

gdalt = DimArray(ssj_ds["gdalt"])
gdlat = DimArray(ssj_ds["gdlat"])
glon = DimArray(ssj_ds["glon"])
times = gdalt.dims[1]
make_lstar.(times, GDZ.(gdalt, gdlat, glon), ((; Kp = 40.0),); kext = "T89")
```

## Caveats

There are strange spikes in GLON (Geographic Longitude) values in files downloaded from Madrigal.

```@example caveat
using DMSPData
using Dates
using DimensionalData
using CairoMakie, SpacePhysicsMakie

t0 = DateTime("2010-01-10T1")
t1 = DateTime("2010-01-10T3")

ssj_ds = SSJ_Dataset(16, t0, t1)
ds = DimStack(ssj_ds, ("gdlat", "glon", "gdalt"))
tplot(ds)
```

There are inconsistencies between the calculated MLAT from the AACGM library and the stored MLAT values in the file.

```@example caveat
using SpaceDataModel: setmeta
using GeoAACGM

da = cat(ds.gdlat, ds.glon, ds.gdalt; dims=2)
dmsp_calc_aacgm = geod2aacgm(da)
dmsp_calc_mlat = setmeta(dmsp_calc_aacgm[:,1], :labels => "AACGM", :ylabel => "MLAT")
dmsp_file = DimStack(ssj_ds, ("mlat", "mlt"))
dmsp_file_mlat = setmeta(dmsp_file.mlat, :labels => "File", :ylabel => "MLAT")

tplot([[dmsp_calc_mlat, dmsp_file_mlat],])
```

## API

```@autodocs
Modules = [DMSPData]
```

### Experiment Notes

```@example quicklook
ssj_ds.notes
```

## Bibliography

```@bibliography
```

## Reproducibility

```@raw html
<details><summary>The documentation of this package was built using these direct dependencies,</summary>
```

```@example
using Pkg # hide
Pkg.status() # hide
```

```@raw html
</details>
```

```@raw html
<details><summary>and using this machine and Julia version.</summary>
```

```@example
using InteractiveUtils # hide
versioninfo() # hide
```

```@raw html
</details>
```
