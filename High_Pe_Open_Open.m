clc;clear
% open-open boundary, Levenspiel and Smith
% when Pe is high
syms x
hold on;
Pe = [10,100,200,500,1000];
% Peclet numbers

% Analytical solutions and plotting
for i = 1:length(Pe)
    f = ezplot(1/(2*sqrt(pi*(1/Pe(i))*x))*exp(-(1-x)^2/4/(1/Pe(i))/x), [0, 2.5]);
    set(f, 'LineWidth', 2);
end

xlabel('\theta');
ylabel('f(\theta)');
grid on;
grid minor;
title('Open-Open Boundary, High Pe');
ylim([0, 10]);
h = legend(string(Pe));
set(gca, 'FontSize', 20);
set(h, 'Box', 'off');