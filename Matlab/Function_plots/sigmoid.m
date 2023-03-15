clear;clc;clf;
input = -10:0.1:10;
sigmoid_f = 1./(1+exp(-input));
plot(input,sigmoid_f, 'b')
ylim([-0.2 1.2])
hold on
grid on
yticks([0 0.5 1])
plot([-10 10], [0.5 0.5], ':k');
plot([-10 10], [0 0], ':k');
plot([-10 10], [1 1], ':k');
plot([0 0], [-0.4 1.4], 'k');
title("Sigmoida")
xlabel("X")
ylabel("Y")