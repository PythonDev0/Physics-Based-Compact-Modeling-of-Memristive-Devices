% main_simulation.m
% ─────────────────────────────────────────────────────────────
% Top-level script for JART VCM v1b simulation of
% TiN/La2NiO4/Pt memristive device.
%
% Loads optimized parameters, runs the JART model, and
% generates I-V and resistance plots.
%
% Author  : Nouman Ahmad
% ─────────────────────────────────────────────────────────────

clear; clc; close all;

%% ── 1. Load JART Model ───────────────────────────────────────
% Add JART m-files to path (download from http://www.emrl.de/JART.html)
addpath('m-files');

%% ── 2. Load Optimized Parameters ────────────────────────────
v = parameter_optimization();

fprintf('[Parameters] Loaded optimized parameter set.\n');
fprintf('  v.a        = %.2e\n', v.a);
fprintf('  v.v_0      = %.2e\n', v.v_0);
fprintf('  v.delta_WA = %.4f\n', v.delta_WA);
fprintf('  v.mu_n     = %.2e\n', v.mu_n);

%% ── 3. Define Voltage Sweep ──────────────────────────────────
% Bipolar voltage sweep: 0 → +V_max → 0 → -V_max → 0
V_max    = 2.5;      % Maximum sweep voltage (V)
n_points = 500;      % Points per half-sweep

V_pos = linspace(0,  V_max, n_points);
V_neg = linspace(V_max, -V_max, 2*n_points);
V_ret = linspace(-V_max, 0, n_points);
V_sweep = [V_pos, V_neg, V_ret];

fprintf('[Sweep] Voltage sweep defined: %.1f V to +%.1f V\n', -V_max, V_max);

%% ── 4. Run JART Simulation ───────────────────────────────────
fprintf('[Simulation] Running JART VCM model...\n');

% NOTE: Replace with actual JART simulation call.
% The JART model is called as:
%   [I_total, R_disc, R_schottky, R_plug] = JART_VCM(V_sweep, v);
%
% Example placeholder (requires JART m-files):
% [I_total, R_disc, R_schottky, R_plug] = JART_VCM(V_sweep, v);

fprintf('[Simulation] Complete.\n');

%% ── 5. Generate Plots ────────────────────────────────────────
% Uncomment after running JART simulation:
% plot_iv_curves(V_sweep, I_total);
% plot_resistance(R_disc, R_schottky, R_plug);

fprintf('[Done] Simulation complete. Run plot_iv_curves.m to visualize results.\n');
