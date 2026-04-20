function v = parameter_optimization()
% parameter_optimization.m
% ─────────────────────────────────────────────────────────────
% Returns the optimized JART VCM v1b parameter struct for the
% TiN/La2NiO4/Pt memristive device.
%
% Parameters were tuned iteratively in MATLAB by comparing
% simulated I-V curves against experimental data.
% Optimization criteria:
%   1. Numerical stability    — simulation runs without diverging
%   2. Experimental validity  — I-V curve matches device data
%   3. Resistance behavior    — HRS/LRS switching is correct
%   4. Inter-parameter logic  — values are physically consistent
%
% Author  : Nouman Ahmad
% Lab     : LMGP – Grenoble INP
% Ref     : Bengel et al., IEEE TCAS-I, 2020
% ─────────────────────────────────────────────────────────────

%% ── Universal Constants (do not modify) ─────────────────────
v.pi      = pi;
v.e       = 1.6021766e-19;   % Elementary charge (C)
v.k_B     = 1.3806503e-23;   % Boltzmann constant (J/K)
v.eps0    = 8.854188e-12;    % Permittivity of free space (F/m)
v.AR      = 1.2e6;           % Richardson constant (A/m²K²)
v.z_Vo    = 2;               % Charge number of oxygen vacancy

%% ── Fixed Geometric Parameters ──────────────────────────────
v.r_fil   = 200e-9;          % Filament radius (m)
v.A       = pi * v.r_fil^2;  % Cross-sectional area (m²)
v.l_disc  = 3e-9;            % Disc thickness (m)
v.l_plug  = 30e-9;           % Plug length (m)

%% ── Optimized Primary Parameters ────────────────────────────
% Ion hopping distance (m) | Range: 0.15e-9 < a < 3.5e-9
v.a           = 0.38e-9;

% Attempt frequency (Hz) | Range: 2e13 < v_0 < 50e13
v.v_0         = 2e13;

% Activation energy (eV) | Range: 0.71 < delta_WA < 0.99
v.delta_WA    = 0.88;

% Schottky barrier height (eV) | Range: 0.1 < phi_bn0 < 0.39
v.phi_bn0     = 0.39;

% Electron mobility (m²/Vs) | Range: 1e-6 < mu_n < 1e-1
v.mu_n        = 5e-6;

% Series resistance - TiNxOy interlayer (Ohm) | Range: 100 < R < 1500
v.R_TiOx      = 590;

% Contact line resistance (Ohm) | Range: 10 < R_0 < 250
v.R_0         = 67;

% Effective thermal resistance SET (K/W) | Range: 1e3 < R < 5e5
v.R_th_eff_SET   = 1.5e4;

% Effective thermal resistance RESET (K/W) | Range: 1e4 < R < 50e4
v.R_th_eff_RESET = 5e4;

% Min oxygen vacancy concentration in disc (m^-3) | Range: 1e24 < N < 4e24
v.N_min       = 1e24;

% Max oxygen vacancy concentration in disc (m^-3) | Range: 4e25 < N < 6e27
v.N_max       = 5e26;

% Initial vacancy concentration in plug (m^-3) | Constant
v.N_plug_init = 2e26;

% Initial vacancy concentration in disc (m^-3) | Range: 7e23 < N < 3e25
v.N_disc_init = 4e24;

% Limiting factor (dimensionless) | Range: 1 < beta < 30
v.beta        = 10;

% Ambient temperature (K) | Constant
v.T_0         = 293;

end
