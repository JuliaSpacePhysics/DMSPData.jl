# DMSPData.jl

[![Build Status](https://github.com/JuliaSpacePhysics/DMSPData.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaSpacePhysics/DMSPData.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/JuliaSpacePhysics/DMSPData.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/JuliaSpacePhysics/DMSPData.jl)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

Access and process [Defense Meteorological Satellite Program](https://www.wikipedia.org/wiki/Defense_Meteorological_Satellite_Program) data from the [Madrigal database](https://cedar.openmadrigal.org/).

**Installation**: at the Julia REPL, run `using Pkg; Pkg.add("DMSPData")`

**Documentation**: [![Dev](https://img.shields.io/badge/docs-dev-blue.svg?logo=julia)](https://JuliaSpacePhysics.github.io/DMSPData.jl/dev/)

## Features and Roadmap

- Data Access
    - [x] [SSJ/4][ssj4ncei] - Special Sensor J/4 - Precipitating Ion and Electron (30ev - 30 KeV) Monitor ([Boston College, ISR](https://dmsp.bc.edu/html2/dmspssj4.html))
    - [ ] SSIE, SSIES, SSIES2, SSIES3 - Thermal Plasma Monitor (Boston College, ISR & Univ of Texas at Dallas)
        - [x] Madrigal S1 (scalar 1 second cadence) : electron density and ion velocity
        - [x] Madrigal S4 (scalar 4 second cadence) : ion and electron temperature, electric potential, composition
    - [ ] SSM - Vector Fluxgate Magnetometer (Boston College, ISR & NASA Goddard Spaceflight Center)
    - [ ] SSULI - Limb Scanning Ultraviolet Imager/Spectrometer ( Naval Research Lab., Thermospheric and Ionospheric Physics )
    - [ ] SSUSI - Nadir Scanning Ultraviolet Imager/Spectrometer & Photometer (Johns Hopkins Univ, Applied Physics Lab.)
    - [ ] SSJSTAR - Penetrating Particle ( > 1 MeV ) Monitor (USAF Research Lab, Space Vehicle Dir.) - a predecessor to the Compact Environmental Anomaly (CEASE) instrument

## Links and References

- [DMSP Space Weather Data Survey](https://dmsp.bc.edu/index.html)
    - [General Characteristics](https://dmsp.bc.edu/html2/ssiesdmspgeneral.html)
- [Defense Meteorological Satellite Program (DMSP) | National Centers for Environmental Information (NCEI)](https://www.ncei.noaa.gov/products/satellite/defense-meteorological-satellite-program)
    - [Data Access](https://www.ngdc.noaa.gov/stp/satellite/dmsp/)
- [Fact Sheets - United States Space Force](https://www.spaceforce.mil/About-Us/Fact-Sheets/Article/2197779/defense-meteorological-satellite-program/)

## Elsewhere

- [GeospaceLAB](https://github.com/JouleCai/geospacelab): A Python-based framework for data access, analysis, and visualization; it supports DMSP SSJ, SSIES, SSUSI, SSM data access.
- [DMSP SSJ Boundaries - ocbpy](https://ocbpy.readthedocs.io/en/latest/examples/ex_dmsp.html)
- [lkilcommons/ssj_auroral_boundary](https://github.com/lkilcommons/ssj_auroral_boundary): Identify boundaries of the aurora with Defense Meteorology Satellite Program (DMSP) electron precipitation


[ssj4ncei]: https://www.ncei.noaa.gov/products/dmsp-j4-precipitating-electron-ion-spectrometer