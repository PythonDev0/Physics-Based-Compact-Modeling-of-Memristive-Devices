% plot_iv_curves.m
% ─────────────────────────────────────────────────────────────
% Plots simulated I-V curves vs experimental data.
% Generates the hysteresis comparison figure showing:
%   - Experimental I-V (multi-cycle)
%   - Base JART model I-V
%   - Optimized TiN/La2NiO4/Pt model I-V
%
% ─────────────────────────────────────────────────────────────

function plot_iv_curves(V_sweep, I_simulated, I_experimental)
% PLOT_IV_CURVES  Compare simulated and experimental I-V curves.
%
%   plot_iv_curves(V_sweep, I_simulated)
%   plot_iv_curves(V_sweep, I_simulated, I_experimental)

figure('Name', 'I-V Curve Comparison', 'Position', [100 100 1200 450]);

%% ── Panel 1: Experimental I-V ────────────────────────────────
subplot(1, 3, 1);
if nargin >= 3 && ~isempty(I_experimental)
    semilogy(V_sweep, abs(I_experimental), 'k-', 'LineWidth', 1.2);
else
    % Placeholder axes
    axis([-3 3 1e-9 1e-1]);
    text(0, 1e-4, 'Load experimental data', ...
        'HorizontalAlignment', 'center', 'FontSize', 9, 'Color', 'gray');
end
xlabel('Voltage (V)');
ylabel('|Current| (A)');
title('Experimental I-V Curve');
grid on;
set(gca, 'YScale', 'log');
box on;

%% ── Panel 2: Base JART Model ─────────────────────────────────
subplot(1, 3, 2);
if nargin >= 2 && ~isempty(I_simulated)
    semilogy(V_sweep, abs(I_simulated), 'b-', 'LineWidth', 1.5);
else
    axis([-3 3 1e-9 1e-1]);
    text(0, 1e-4, 'Run simulation first', ...
        'HorizontalAlignment', 'center', 'FontSize', 9, 'Color', 'gray');
end
xlabel('Voltage (V)');
ylabel('|Current| (A)');
title('JART Model I-V');
grid on;
set(gca, 'YScale', 'log');
box on;

%% ── Panel 3: Optimized Model ─────────────────────────────────
subplot(1, 3, 3);
if nargin >= 2 && ~isempty(I_simulated)
    semilogy(V_sweep, abs(I_simulated), '-', ...
        'Color', [0.85 0.55 0.1], 'LineWidth', 1.5);
    hold on;
    if nargin >= 3 && ~isempty(I_experimental)
        semilogy(V_sweep, abs(I_experimental), 'b--', ...
            'LineWidth', 1.0, 'DisplayName', 'Experimental');
        legend('Optimized model', 'Experimental', 'Location', 'southeast');
    end
else
    axis([-3 3 1e-9 1e-1]);
    text(0, 1e-4, 'Run simulation first', ...
        'HorizontalAlignment', 'center', 'FontSize', 9, 'Color', 'gray');
end
xlabel('Voltage (V)');
ylabel('|Current| (A)');
title('TiN/La_{2}NiO_{4}/Pt Optimized');
grid on;
set(gca, 'YScale', 'log');
box on;

sgtitle('I-V Curve Comparison: Experimental vs JART vs Optimized', ...
    'FontSize', 13, 'FontWeight', 'bold');

% Save figure
saveas(gcf, '../results/iv_curve_comparison.png');
fprintf('[Plot] I-V comparison saved to results/iv_curve_comparison.png\n');

end
