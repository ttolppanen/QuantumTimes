module QuantumTimes

using GLM

export exp_fit_model
export exp_fit
export t_time
export t2

function exp_fit_model(x, y, c = nothing)
    y_log = log.(y)
    if isa(c, Nothing)
        model = lm(@formula(y_log ~ x), (; x, y_log))
    else
        y_log = y_log .- log(c)
        model = lm(@formula(y_log ~ 0 + x), (; x, y_log))
    end
    return model
end

function exp_fit(x, y, c = nothing)
    model = exp_fit_model(x, y, c)
    if isa(c, Nothing)
        intercept = exp(coef(model)[1])
        slope = coef(model)[2]
    else
        intercept = c
        slope = coef(model)[1]
    end
    return intercept, slope, x -> intercept * exp.(slope * x)
end

function t_time(x, y, c = nothing)
    model = exp_fit_model(x, y, c)
    slope = coef(model)[2]
    return -1 / slope
end

function t2(t1, pure_t2)
    return 1 / ((1 / (2*t1)) + (1/pure_t2))
end

end # module QuantumTimes
