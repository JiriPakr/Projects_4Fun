clear;clc;

% calculates primes from N
n = 3000;
primes = [];

for j = n:-1:2
    nums = mod(j,(2:j-1));
    if min(nums) > 0
        primes(length(primes)+1) = j;
    end
end

primes(length(primes)+1) = 2;
primes
