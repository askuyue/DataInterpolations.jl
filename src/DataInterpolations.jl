module DataInterpolations

### Interface Functionality

abstract type AbstractInterpolation{FT,T} <: AbstractVector{T} end

Base.size(A::AbstractInterpolation) = size(A.u)
Base.size(A::AbstractInterpolation{true}) = length(A.u) .+ size(A.t)
Base.getindex(A::AbstractInterpolation,i) = A.u[i]
Base.getindex(A::AbstractInterpolation{true},i) = i<=length(A.u) ? A.u[i] : A.t[i-length(A.u)]
Base.setindex!(A::AbstractInterpolation,x,i) = A.u[i] = x
Base.setindex!(A::AbstractInterpolation{true},x,i) =
                                   i <= length(A.u) ? (A.u[i] = x) : (A.t[i-length(A.u)] = x)

using LinearAlgebra, RecursiveArrayTools, RecipesBase, Reexport
@reexport using GaussianProcesses, Optim

include("interpolation_caches.jl")
include("interpolation_utils.jl")
include("interpolation_methods.jl")
include("plot_rec.jl")

export LinearInterpolation, QuadraticInterpolation, LagrangeInterpolation, AkimaInterpolation,
       ConstantInterpolation, QuadraticSpline, CubicSpline, BSplineInterpolation, BSplineApprox,
       Loess, GPInterpolation, Curvefit

# Deprecated April 2020
export ZeroSpline

end # module
