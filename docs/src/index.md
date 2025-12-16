```@meta
CurrentModule = DMSPData
```

# DMSPData.jl

Access and process [Defense Meteorological Satellite Program](https://www.wikipedia.org/wiki/Defense_Meteorological_Satellite_Program) (DMSP) data.

```@index
```

## Installation

```julia
using Pkg
Pkg.add("DMSPData")
```

## Usage

```@example usage
using DMSPData
```

## Madrigal

8100 is the instrument ID for DMSP in Madrigal database.

```@example quicklook
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
using DMSPData
using DimensionalData

ssj_ds = SSJ_Dataset(16, t0, t1)
```

```@example quicklook
s1_ds = S1_Dataset(16, t0, t1)
s4_ds = S4_Dataset(16, t0, t1)
```

```@example quicklook
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

Experiment Notes

```@example quicklook
ssj_ds.notes
```

## API

```@autodocs
Modules = [DMSPData]
```

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
