% plot_resistance.m
% ─────────────────────────────────────────────────────────────
% Plots Disc, Schottky, Plug, and Series resistance vs time.
% Used to verify correct HRS/LRS switching behavior during
% SET and RESET cycles.
%
% Author  : Nouman Ahmad
% Lab     : LMGP – Grenoble INP
% ─────────────────────────────────────────────────────────────

function plot_resistance(t, R_schottky, R_disc, R_plug, R_series)
% PLOT_RESISTANCE  Plot resistance components vs time.
%
%   plot_resistance(t, R_schottky, R_disc, R_plug, R_series)
%
%   All resistance arrays must be the same length as t.

figure('Name', 'Resistance vs Time', 'Position', [100 100 900 500]);

%% ── Schottky Resistance ──────────────────────────────────────
subplot(1, 2, 1);
if nargin >= 3
    semilogy(t, R_schottky, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Schottky');
    hold on;
    semilogy(t, R_disc,     'r-', 'LineWidth', 1.5, 'DisplayName', 'Disc');
    semilogy(t, R_plug,     'm-', 'LineWidth', 1.2, 'DisplayName', 'Plug');
    if nargin == 5
        semilogy(t, R_series, 'g-', 'LineWidth', 1.2, 'DisplayName', 'Series');
    end
    legend('Location', 'best');
else
    text(0.5, 0.5, 'Provide resistance arrays', ...
        'Units', 'normalized', 'HorizontalAlignment', 'center', ...
        'FontSize', 9, 'Color', 'gray');
end
xlabel('Time (s)');
ylabel('Resistance (\Omega)');
title('All Resistance Components');
grid on;
set(gca, 'YScale', 'log');

% Annotate SET and RESET regions
xline(1.0, '--k', 'SET',   'LabelVerticalAlignment', 'bottom', 'FontSize', 8);
xline(2.2, '--k', 'RESET', 'LabelVerticalAlignment', 'bottom', 'FontSize', 8);
box on;

%% ── Disc Resistance Only ─────────────────────────────────────
subplot(1, 2, 2);
if nargin >= 3
    semilogy(t, R_disc, 'r-', 'LineWidth', 2.0);
    xlabel('Time (s)');
    ylabel('Resistance (\Omega)');
    title('Disc Resistance');
    grid on;
    set(gca, 'YScale', 'log');
    xline(1.0, '--k', 'SET',   'LabelVerticalAlignment', 'bottom', 'FontSize', 8);
    xline(2.2, '--k', 'RESET', 'LabelVerticalAlignment', 'bottom', 'FontSize', 8);
    box on;
end

sgtitle('Resistance vs Time — SET & RESET Cycle', ...
    'FontSize', 13, 'FontWeight', 'bold');

saveas(gcf, '../results/resistance_vs_time.png');
fprintf('[Plot] Resistance plot saved to results/resistance_vs_time.png\n');

end
