% Nahodne prohledavani
clear,clc,clf;

Sx = 0;
best = inf;
x = 1:1000;



for i = 1:1e6 % Milion operaci
    random_pos = Sx + rand()-0.5;
    new_score = neznama_fce1(random_pos);
    
    if new_score < best
        best = new_score;
        Sx = random_pos;
    end
end
for i = 1:length(x)
    y(i) = neznama_fce1(x(i));
end


plot(x,y)
hold on
plot(Sx, neznama_fce1(Sx),"rx")

% DU - slozitejsi fce (rastrigin 2d), nahodne prohledavani
