
[![Build Status](https://github.com/JuliaSpacePhysics/DMSPData.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaSpacePhysics/DMSPData.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/JuliaSpacePhysics/DMSPData.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/JuliaSpacePhysics/DMSPData.jl)

> Each DMSP satellite has a 101 minute, sun-synchronous near-polar orbit at an altitude of 830km above the surface of the earth. The visible and infrared Operational Linescan System (OLS) sensors collect images across a 3000km swath, providing global coverage twice per day. The combination of day/night and dawn/dusk satellites monitors global information such as clouds every six hours. The microwave imager (MI) and sounders (T1, T2) cover one half the width of the visible and infrared swath. These instruments cover polar regions at least twice and the equatorial region once per day. The space environment sensors (J4, M, IES) record along-track plasma densities, velocities, composition and drifts.


- [ ] There are strange spikes for GLON (Geographic longitude) from files downloaded from Madrigal. Also, there's inconsistency between the MLT from the file downloaded and the MLT calculated.


## Quicklooks

[Madrigal experiment](https://cedar.openmadrigal.org/single?isGlobal=on&categories=9&instruments=8100&years=2018&months=3&days=9)

- https://cedar.openmadrigal.org/static/experiments3/2020/dms/01jan20/plots/lowlatf18001.html
    - https://cedar.openmadrigal.org/static/experiments3/2018/dms/08mar18/plots/f17smlowlat2018mar08.png
- https://cedar.openmadrigal.org/static/experiments3/2020/dms/01jan20/plots/f18_20jan01.htm

## Data Availability

- SSJ data is also available from NOAA for a limited time 2010-2014, for example https://www.ncei.noaa.gov/data/dmsp-space-weather-sensors/access/f16/ssj/2012/10/

- [DMSP raw data formats](https://cedar.openmadrigal.org/static/siteSpecific/dmsp_afrl_file_format_descriptions.pdf)

Table 22: SSJ Sensor Values for Channel Central Energy (Eᵢ) and Channel Spacing (ΔEᵢ)

| Channel | Eᵢ (eV) | ΔEᵢ (eV) | Channel | Eᵢ (eV) | ΔEᵢ (eV) |
|--------:|--------:|----------:|--------:|--------:|----------:|
| 1  | 30000 | 9600  | 11 | 949  | 373   |
| 2  | 20400 | 8050  | 12 | 646  | 254.5 |
| 3  | 13900 | 5475  | 13 | 440  | 173   |
| 4  | 9450  | 3720  | 14 | 300  | 118   |
| 5  | 6460  | 2525  | 15 | 204  | 80.5  |
| 6  | 4400  | 1730  | 16 | 139  | 54.5  |
| 7  | 3000  | 1180  | 17 | 95   | 37    |
| 8  | 2040  | 804   | 18 | 65   | 25.5  |
| 9  | 1392  | 545.5 | 19 | 44   | 17.5  |
| 10 | 949   | 373   | 20 | 30   | 14    |

- [Frequently Asked Question About the DMSP High Latitude Plots](https://dmsp.bc.edu/html2/faq.html)