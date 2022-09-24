clear;clc;

n = 3000;
primes = [2];

for j = 3:n
    for i = 2:j-1  
        if mod(j,i) == 0
            break;
        end
        if i+1 == j
            primes(length(primes)+1) = i+1;
        end
    end
end

primes
max(primes)