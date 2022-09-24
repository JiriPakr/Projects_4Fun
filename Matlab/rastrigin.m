% Source: https://en.wikipedia.org/wiki/Rastrigin_function
function [y] = rastrigin(x)
    n = length(x);
    y = 10*n + sum(x.^2 - 10*cos(2*pi*x));    
end