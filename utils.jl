# using DSP
# using WAV
# using Plots
# using Random
# using FFTW
# using StatsBase


"""
Computes the frequency response, imput impedance,
and radiation impedance using a transmission line
model of the vocal tract. The model is a recreation
of Dr. Brad Story's MATLAB code which performs the
same function. His model is based on that described in 
[Sondhi and Schroeter (1987)](https://doi.org/10.1109/TASSP.1987.1165240).

The arguments to the function are:
- `a`: the area function which approximates the vocal tract (area as a function of distance from glottis)
- `l`: the length of each tubelet in the area function
- `cutoff`: the hard walled tube to extend the vocal tract (only used for impedance studies and normally set to number of tubelets+1)
- `max_f`: the ceiling of the frequency response
- `r`: the ratio of yielding wall resistance to mass
- `fw`: mechanical resonance frequency of the wall
- `ft`: lowest resonant frequency of the tract when closed on both ends 
- `q`: correction for thermal conductivity and viscosity normally set to 4 rad/s
- `c`: speed of sound
- `ρ`: density of air
"""
function transmission_line_model(
    a::Vector{Float64}=fill(1.0,44),
    l::Vector{Float64}=fill(.4,44),
    cutoff::Int64=45,
    max_f::Int64=5000,
    r::Int64=408,
    fw::Int64=15,
    ft::Int64=200,
    q::Float64=4.0,
    c::Float64=35000.0,
    ρ::Float64=0.00114,
)

    # Preliminary calculations
    n_sections = length(a) # number of sections in area function
    n_points = Int64(round(max_f/5)) # maximum points in frequency spectrum
    delta_f = max_f/n_points
    frequencies = [delta_f:delta_f:delta_f*n_points;] # the frequencies at which response and impedance are calculated
    n_frequencies = length(frequencies) # number of frequencies at which ...
    ω = (2*π) .* frequencies # TODO define the rest below
    α = zeros(n_frequencies, 1) + im*(q*ω) 
    α = sqrt.(α)
    temp1 = r*ones(n_frequencies, 1) + im*(ω)
    temp2 = zeros(n_frequencies, 1) + im*(ω)
    den = temp1 .* temp2
    temp1 = ((2*π*fw)^2)*ones(n_frequencies, 1) + im*zeros(n_frequencies, 1)
    den = den + temp1
    num = zeros(n_frequencies, 1) + im*ω*(2*π*ft)^2
    β = (num ./ den) + α

    # print("Preliminary calculations complete")

    # Main loop
    # These are the ABCD matrices that make up the chain matrix for the vocal tract.
    # They are based on electrical transmission line theory.

    A = ones(n_points, 1);
    C = zeros(n_points, 1);
    B = zeros(n_points, 1);
    D = ones(n_points, 1);

    for k in 1:n_sections
    # for k in 1:3
        # println("iteration ", k)

        temp1 = r*ones(n_frequencies, 1) + im*(ω)
        temp2 = β + (zeros(n_frequencies, 1) + im*ω)
        γ = sqrt.(temp1 ./ temp2)
        σ = γ .* temp2

        nA = cosh.((l[k]/c) * σ)
        temp1 = -ρ*c/a[k] * γ
        nB = temp1 .* sinh.( (l[k]/c) * σ)
        temp1 = ones(length(γ), 1) ./ γ
        temp2 = -a[k]/(ρ*c) * temp1
        nC = temp2 .* sinh.((l[k]/c) * σ)
        nD = nA

        M1 = [A B; C D]
        M2 = [nA nB; nC nD]

        # println("M1: ", M1)
        # println(size(M1))
        # println("M2: ", M2)
        # println(size(M2))

        # M1 = vcat([A B], [C D])
        # M2 = vcat([nA nB], [nC nD])

        A = M2[1:n_points, 1].*M1[1:n_points, 1] + M2[1:n_points, 2].*M1[n_points+1:end, 1]
        B = M2[1:n_points, 1].*M1[1:n_points, 2] + M2[1:n_points, 2].*M1[n_points+1:end, 2]
        C = M2[n_points+1:end, 1].*M1[1:n_points, 1] + M2[n_points+1:end, 2].*M1[n_points+1:end, 1]
        D = M2[n_points+1:end, 1].*M1[1:n_points, 2] + M2[n_points+1:end, 2].*M1[n_points+1:end, 2]

        # println("A: ",A)
        # println("B: ",B)
        
    end
    # println("Finished loop")

    # Final calculations
    R = 128 .* ρ*c/(9*π^2 * a[n_sections])    
    L = 8 .* ρ*c/((3*π*c)*sqrt.(a[n_sections]*π)) 	
    
    temp1 = zeros(n_points, 1) + im*R*L*ω
    temp2 = R*ones(n_points, 1) + im*L*ω
    Zrad = temp1 ./ temp2

    temp1 = (Zrad .* D) - B
    temp2 = A - (C .* Zrad)
    z = temp1 ./ temp2
    h = Zrad ./ temp2
    f = frequencies

    S = temp2 ./ temp1

    h_alt = (-C .* B) ./ A+D

    # println("Calculations complete")

    return f, h, z, Zrad

end