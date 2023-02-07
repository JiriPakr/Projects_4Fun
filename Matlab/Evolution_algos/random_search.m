clear,clc,clf;

% globalni min pro rastrigin fci = [0,0]
Sx = 0;
x = (-5.12:0.1:5.12);
% Rastigin
func = @(x) 10*length(x) + sum(x.^2 - 10*cos(2*pi*x));       % lambda fce dle rastrigin.m
dx=length(x);

best = random_search1(func,Sx);

% Získání y pro vykreslení fce
for i = 1:length(x)
    y(i) = func(x(i));
end
plot(x,y)
hold on
plot(best, func(best),"ro")
xlabel("x")
ylabel("y")
title("Rastrigin function")
legend("Fuction", "Minimum")

Sx = 0;

function [best] = random_search1(func,Sx)
% Nahodne prohledavani - hledani minima (idealně globálního)
% V případě nalezení lokálního minima - spustit znovu :)
best = inf;
for i = 1:1e7 
    random_pos = Sx + rand()-0.5;         
    new_score = func(random_pos);
    
    if new_score < best
        best = new_score;
        Sx = random_pos;
    end
end
end


