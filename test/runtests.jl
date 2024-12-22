using Test, QuantumTimes
using Plots

@testset "QuantumTimes" begin
    
    @testset "exp_fit" begin
        intercept = rand()
        slope = 1 + rand()
        N = 50
        x = range(0, 100, length = N)
        y = intercept * exp.(slope * (x .+ rand(N)))
        r_int, r_slp, fit = exp_fit(x, y)
        pl = plot(x, y, st = :scatter, yaxis = :log10)
        plot!(pl, x, fit)
        savefig(joinpath(@__DIR__, "exp_fit"))

        r_int, r_slp, fit = exp_fit(x, y, intercept)
        pl = plot(x, y, st = :scatter, yaxis = :log10)
        plot!(pl, x, fit)
        savefig(joinpath(@__DIR__, "exp_fit_c"))
        @test fit[1] == intercept
        @test intercept == r_int
    end

    @testset "t_time" begin
        intercept = rand()
        slope = -1 / (1 + rand())
        N = 50
        x = range(0, 100, length = N)
        y = intercept * exp.(slope * (x .+ rand(N)))
        t = t_time(x, y)
        @test round(-1 / slope, digits=1) == round(t, digits=1)  
    end

    @testset "t2" begin
        t1 = 1 + rand()
        pure_t2 = 1 + rand()
        @test 1 / t2(t1, pure_t2) == (1 / (2*t1) + 1 / (pure_t2))
    end

end # testset 