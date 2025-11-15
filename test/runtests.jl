using DMSPData
using Test
using Aqua

@testset "DMSPData.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(DMSPData)
    end
    # Write your tests here.
end
