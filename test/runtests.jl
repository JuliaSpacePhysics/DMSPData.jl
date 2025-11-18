using DMSPData
using Test
using Aqua

@testset "DMSPData.jl" begin
    t0 = "2010-01-10T00:04"
    t1 = "2010-01-10T00:35"
    ds = SSJ_Dataset(16, t0, t1)
    @test keys(ds) == ["el_i_ener", "el_i_flux", "el_m_ener", "gdalt", "gdlat", "glon", "ion_i_ener", "ion_i_flux", "ion_m_ener", "mlat", "mlong", "mlt", "sat_id", "ch_ctrl_ener", "el_d_ener", "el_d_flux", "ion_d_ener", "ion_d_flux"]
end


@testset "Code quality (Aqua.jl)" begin
    Aqua.test_all(DMSPData)
end
