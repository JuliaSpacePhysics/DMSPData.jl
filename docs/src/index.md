```@meta
CurrentModule = DMSPData
```

# DMSPData.jl

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

```@example quicklook
using DMSPData.Madrigal
using Dates

t0 = DateTime("2010-01-10T00:04")
t1 = DateTime("2010-01-10T00:35")

get_experiments(8100, t0, t1)
get_instrument_files(8100, t0, t1)
```

## Quicklook

Here we reproduce the figure 3 in [F16 10 January 2010 first auroral crossing of the day](https://doi.org/10.1029/2009JA014362).

<!-- @redmonNewDMSPDatabase2017 -->

<!-- F16 10 January 2010 first auroral crossing of the day. (a) Background adjusted electron differential energy flux (jE) (eV/cm2 sr ΔeV s), (b) integrated electron energy flux (JE) (eV/cm2 sr s), (c) average electron energy (Eavg) (eV), (d–f) same quantities for ions, and (g) AACGM latitude and MLT (right y axis). Uncertainty bars are shown for the integral quantities (Figures 3b, 3c, 3e, and 3f) but not for the differential quantities. -->

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
using CairoMakie

vars = ("el_d_ener", "el_i_ener", "el_m_ener", "ion_d_ener", "ion_i_ener", "ion_m_ener", "mlat")
ds = DimStack(ssj_ds, vars; data_params = DMSPData.ssj_metadata_patch)[Ti(t0..t1)]
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

Experiment Notes

```@example quicklook
ssj_ds.notes
```

## API

```@autodocs
Modules = [DMSPData]
```
