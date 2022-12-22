clear;clc;close all;

%% Gen Algo 0.2v
% ukonceni -    N spusteni
%               N evaluaci
%               Delta, algo se prestane zlepsovat o delta -> konec

%1 Init
%2 Eval
%3 Selekce
%4 Crossover
%5 Mutace
% if ok end

%% Init parameters
% problem params
range = [-5.12, 5.12];
x = linspace(range(1),range(2),1000);
y = arrayfun(@CF,x);
plot(x,y)
% GA params
inds = 100; % individuals
iter = 100;
bits = 20;
tournSize = 10;
mutProb = 1/inds;
% GA run
pop = initPopulation(inds, bits);

for gen = 1:iter
    % eval
    popR = realPop(pop, range, bits);
    CFvalues = cellfun(@CF,popR);
    %hold on
    plot(x,y,cell2mat(popR),CFvalues,'*');
    newPopulation = cell(size(pop));
    for i = 1:inds/2
    % selection
        parentA = GAselection(pop,CFvalues, tournSize);
        parentB = GAselection(pop,CFvalues, tournSize);
    % crossover
        [ch1,ch2] = GAcrossover(parentA, parentB);
        newPopulation{2*i-1} = ch1;
        newPopulation{2*i} = ch1;

    end
    pop = GAmutation(newPopulation, mutProb);
end
    % mutation
    RP = realPop(pop, range, bits)';
    CFv = cellfun(@CF, RP);
    r = sortrows([cell2mat(RP),CFv],2);
    r(1:5,:)

%% other funs
function value = CF(x)  %cost function
    value = 10+sum(x.^2-10*cos(2*pi*x));
end

function pop = initPopulation(inds, bits)
    pop = cell(1,inds);
    for i=1:inds
        pop{i} = dec2bin(round(rand()*(2^bits-1)),bits);
    end
end

function rp = realPop(pop, range, bits)
    rp = cell(size(pop));
    for i=1:length(rp)
        rp{i} = bin2dec(pop{i})/(2^bits-1)*(range(2)-range(1))+range(1);
    end 
end

function parent = GAselection(pop, CFvalues, tournamentSize)
    i = round(rand(1,tournamentSize)*(length(pop)-1)+1);
    indices = 1:length(pop);
    result = sortrows([indices(i)',CFvalues(i)'],2);
    parent = pop{result(1,1)};
end

function [c1,c2] = GAcrossover(p1,p2)
    n = length(p1);
    % strcat -> string concatenate
    c1 = strcat(p1(1:n/2),p2(n/2+1:end));
    c2 = strcat(p2(1:n/2),p1(n/2+1:end));
end

function pop = GAmutation(pop, prob)
    roll = @(prob) rand()<prob;
    for i = 1:length(pop)
        if roll(prob)
            ind = pop{i};
            bit = round(rand()*(length(ind)-1)+1);
            ind(bit) = dec2bin(~bin2dec(ind(bit)));
            pop{i} = ind;
        end
    end
end