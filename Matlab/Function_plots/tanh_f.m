clear;clc;clf;
input = -10:0.1:10;
tanh_fun = (exp(input)-exp(-input))./(exp(input)+exp(-input));
plot(input,tanh_fun, 'b')
ylim([-1.2 1.2])
hold on
grid on
yticks([-1 0 1])
plot([-10 10], [1 1], ':k');
plot([-10 10], [0 0], ':k');
plot([-10 10], [-1 -1], ':k');
plot([0 0], [-1.4 1.4], 'k');
title("Hyperbolický tangens")
xlabel("X")
ylabel("Y")