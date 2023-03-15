clear;clc;clf;

x1 = -10:0;
y1 = zeros(length(x1));
x2 = 0:10;
y2 = 0:10;
plot(x1,y1, 'b')
hold on
grid on
plot(x2,y2, 'b')
yticks([0 2 4 6 8 10])
ylim([-2 12])
%plot([-10 10], [1 1], ':k');
%plot([-10 10], [0 0], ':k');
%plot([0 0], [-2.4 12.4], 'k');
title("ReLU")
xlabel("X")
ylabel("Y")