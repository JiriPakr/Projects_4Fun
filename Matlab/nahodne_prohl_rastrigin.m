clear,clc,clf;
Sx = 0;
best = inf;             % globalni min pro rastrigin fci = [0,0]
x = (-5.12:0.1:5.12);
y_rastrigin = @(x) 10*length(x) + sum(x.^2 - 10*cos(2*pi*x));       % lambda fce dle rastrigin.m
dx=length(x);

% Nahodne prohledavani - hledani minima (idealně globálního)
% V případě nalezení lokálního minima - spustit znovu :)
for i = 1:1e7 
    random_pos = Sx + rand()-0.5;         
    new_score = y_rastrigin(random_pos);
    
    if new_score < best
        best = new_score;
        Sx = random_pos;
    end
end

% Získání y pro vykreslení fce
for i = 1:length(x)
    y(i) = y_rastrigin(x(i));
end
plot(x,y)
hold on
plot(best, y_rastrigin(best),"ro")
xlabel("x")
ylabel("y")
title("Rastrigin function")
legend("Fuction", "Minimum")