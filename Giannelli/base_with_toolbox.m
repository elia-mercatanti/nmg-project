clear

k = 4;
knots = [0 0 0 0 1 1 1 1];
tau = linspace(knots(k), knots(end-k+1), 1000);
base = spcol(knots ,k, tau);
hold on;
plot(tau, base, 'linewidth', 2);

