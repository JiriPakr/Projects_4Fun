clc;clear;hold off;
% ukonceni - pocet iter
% custom genetic algorithm - Jiri Pakr, 208971

%% INIT
x = linspace(-5.12,5.12,300);
y = zeros(length(x),1);
boundaries = [-5.12, 5.12];
nIndividuals = 100;
nBits = 16;

crossoverPoints = 0.5;
mutationChance = 1/nIndividuals*2;
%mutationChance = 0;

% random init population
pop0 = initPopulation(nIndividuals);
pop_start = pop0;
% pop{1,1} - vektor hodnot x
% pop{1,1} - vektor hodnot x reprezentované v 16bitech
% hodnoty v half floatech z Fixed-point designer matlab toolboxu

for i =1:length(x)
        y(i) = Rastriginf(x(i));
end
for i =1:length(pop_start{1,1})
        eval_start(i) = Rastriginf(pop_start{1,1}(i));
end

%% GA run
% default settings for 100 generations
% ne vždy najde minimum fce, proto třeba vícekrát spustit
for gen = 1:100
 % evaluate population
    for i =1:length(pop0{1,1})
        eval(i) = Rastriginf(pop0{1,1}(i));
    end
 % selection - tournament - 50 pops
     % tournamentSize = 2
    for j = 1:nIndividuals/2
        rand_indx = ceil(rand(1)*50);
        if eval(j) < eval(rand_indx)
            pop1{1,1}(j) = pop0{1,1}(j);
            pop1{1,2}(j,:) = pop0{1,2}(j,:);
        else
            pop1{1,1}(j) = pop0{1,1}(rand_indx);
            pop1{1,2}(j,:) = pop0{1,2}(rand_indx,:);
        end
    end
% crossover - 1 point - next 50 pops
    % half point crossover
    for jj =  nIndividuals/2:nIndividuals
        rnd_parent1 = ceil(rand(1)*50);
        rnd_parent2 = ceil(rand(1)*50);
        pop1{1,2}(jj,1:8) = (pop1{1,2}(rnd_parent1,1:8));
        pop1{1,2}(jj,9:16) = (pop1{1,2}(rnd_parent2,9:16));
        % magic line - from bin to half float
        pop1{1,1}(jj) =half( typecast(uint16(bin2dec(pop1{1,2}(jj,:))), 'int16') )/100;
    end
%mutation
     %mutace probíhá jen v 7až16bitu, jinak by mutované hodnoty vyskakovali mimo rozsah Rastriginovy fce
     rnd_indxs = rand(100,1);
     a1 = 7; b1 = 16;
     mutations = find(rnd_indxs<=mutationChance);
     for jjj = 1:length(mutations)
        rnd_bit = ceil((b1-a1).*rand + a1);
        if pop1{1,2}(jjj,rnd_bit) == dec2bin(1)
            pop1{1,2}(jjj,rnd_bit) = dec2bin(0);
        else
            pop1{1,2}(jjj,rnd_bit) = dec2bin(1);
        end
     end
    
     if gen ~= 100
        pop0 = pop1;
     end
end
% result
min_fce = Rastriginf(min(abs(pop0{1,1})))

%% Plots
hold all
plot(x,y)
plot(pop_start{1,1},eval_start,'go')
plot(pop0{1,1},eval,'ko')

% plot params
xlabel('X')
ylabel('Y')
legend('Rastrigin fun','start pop','final pop')
grid on

%% Other Functions

function y = Rastriginf(x)
    n = length(x);
    y = 10*n + sum(x.^2 - 10*cos(2*pi*x));    
end

function pop = initPopulation(nIndividuals)
    % namapovat interval (-5.12,5.12) na interval 16bit
    a = -5.12; b = 5.12;
    r = (b-a).*rand(1,nIndividuals) + a;
    %r_range = [min(r) max(r)];
    b2 = dec2bin(r*100,16);
    pop = {half(r),b2};
end