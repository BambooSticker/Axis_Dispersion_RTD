clc; clear;
syms x;

Pe = [0.2, 1, 6, 14, 100]; % Peclet numbers

% Analytical solutions
for i = 1:length(Pe)
    A(i) = 1 / (x / Pe(i))^0.5 * (1 + x) / 2;
    B(i) = 1 / (pi * x / Pe(i))^0.5 * exp(-(1 - x)^2 / (4 * x / Pe(i)));
    C(i) = Pe(i) / 2 * exp(Pe(i));
end

% Plotting
hold on;
for i = 1:length(Pe)
    f(i) = ezplot(B(i) - C(i) * erfc(A(i)), [0, 2.5]);
    set(f(i), 'LineWidth', 2);
end

xlabel('\theta');
ylabel('f(\theta) ');
grid on;
grid minor;
title('Close-Open Boundary, Low Pe');
ylim([0, 10]);
h = legend(string(Pe));
set(gca, 'FontSize', 20);
set(h, 'Box', 'off');