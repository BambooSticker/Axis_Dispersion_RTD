
hold on;
global Nx dx Pe;

% Define the number of grid points and the grid spacing
Nx = 80;
dx = 1 / Nx;

% Define the Péclet numbers
PE = [0.2, 1, 6, 14, 100];

% Initialize the initial condition
Ct0 = zeros(1, Nx + 1);

% Define the time span and the number of time steps
tspan = [0:0.01:4];
Nt = length(tspan);

% Loop over the Péclet numbers
for i = [1:1:5]
    Pe = PE(i);
    
    % Solve the ODE using ode45
    [t, y] = ode45(@dispersionmodel1, tspan, Ct0(1:end));
    
    % Calculate the concentration flux
    for j = 1:Nt - 1
        tt(j) = t(j + 1) - t(j);
        cc(j) = (y(j + 1, end) - y(j, end)) / tt(j);
    end
    
    % Plot the concentration flux
    t(end) = [];
    plot(t, cc, 'LineWidth', 2); 
end    
% Set the plot properties
xlim([0, 2.5]);
ylim([0, 10]);
xlabel('\theta');
ylabel('f(\theta)');
grid on;
grid minor;
title('Close-Close Boundary, Low Pe');
set(gca, 'FontSize', 20);


% Add a legend to the plot
h = legend('0.2', '1', '6', '14', '100');

% Define the dispersion model function
function dydt = dispersionmodel1(t, y)
    global Pe U0;
    U0 = 1;
    dydt = 1 / Pe * centraldiff21(y) - centraldiff1(y);
end

% Define the first-order central difference operator
function dU = centraldiff1(U)
    global dx Nx U0 Pe;
    dU(1) = (U(1) - U0) * Pe;
    for i = 2:Nx
        dU(i) = (U(i + 1) - U(i - 1)) / dx / 2;
    end
    dU(Nx + 1) = dU(Nx);
    dU = dU';
end

% Define the second-order central difference operator
function d2U = centraldiff21(U)
    global dx Nx U0;
    d2U(1) = (U(2) - 2 * U(1) + U0) / dx / dx;
    for i = 2:Nx
        d2U(i) = (U(i + 1) - 2 * U(i) + U(i - 1)) / dx / dx;
    end
    d2U(Nx + 1) = (U(Nx + 1) - 2 * U(Nx) + U(Nx - 1)) / dx / dx;
    d2U = d2U';
end