clear

k = 4;
knots = [0 0 0 0 1 1 1 1];
tau = linspace(knots(k), knots(end-k+1), 1000);
base = spcol(knots ,k, tau);
hold on;
for i = 1 : length(knots) - k
    plot(tau, base(:, i), 'linewidth', 2);
end
