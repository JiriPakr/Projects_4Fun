clc;clear;hold off;
%%
% HC 12 - from https://is.muni.cz/th/ba7sk/bp.pdf
%% INIT

Pop_size = 200;
nParam = 1;
nBitParam = 8;
n = nParam * nBitParam;  % ucelova fce
scale = 50;
% FOR 16 bit chose scale 500
% FOR 8 bit chose scale 10

% Rastrigin
x = linspace(-5.12,5.12,Pop_size);
%y = linspace(-5.12,5.12,Pop_size);
y = zeros(length(x),1);
boundaries = [-5.12, 5.12];


% Rosenbrock
%% DEGUN - doest work for nParam =2 RBfun
%x_rb = linspace(-2,2,300);
%y_rb = linspace(-1,3,300);
%z = zeros(length(x_rb),length(y_rb));
%a = 1;
%b = 100;

rand_idx = ceil(rand(1)*100);

% Matrix of Hamming distances M0,M1,M2 -> M
c0 = 1;
M0 = zeros(c0,n);

% nchoosek - combination - kombinační číslo
c1 = nchoosek(n,1); % colums of M1
M1 = eye(c1,n);

c2 = nchoosek(n,2); % colums of M2
M2 = zeros(c2,n);
row_shift = 1;
count = 1;
% Creation of Matrix with hamming distances 2
for i =(n-1):-1:1
    M2(count:count+i-1,row_shift) = 1;
    row_shift = row_shift+1;
    M2(count:count+i-1,row_shift:n) = eye(i);  
    count = count + i;
% just like    
%M2(1:15,1) = 1;
%M2(1:15,2:16) = eye(15)
%M2(16:29,2) = 1;
%M2(16:29,3:16) = eye(14)
%M2(30:42,3) = 1;
%M2(30:42,4:16) = eye(13)
%...
end

% M matrix
m = c0 + c1 + c2;
M = zeros(m,n);
M(c0,:) = M0;
M(c0+1:c1+1,:) = M1;
M(c1+2:m,:) = M2;

%% Algo
iter = 100;
if nParam == 1
    a_kand = x(rand_idx);
elseif nParam == 2
    a_kand(1,1) = x_rb(rand_idx);
    a_kand(1,2) = y_rb(rand_idx);
end
for i=1:iter
    a_opt = a_kand;
    a_kand = a_kand*scale;

    A = zeros(m,n);
    for i=1:m
        for j=1:n
            gray_temp{1,1} = gray2bin(dec2bin(a_kand,n));
            A(i,j) = xor(M(i,j),str2double(gray_temp{1,1}(1,j)));
        end
    end
   
    a_temp = zeros(m,1);
    for j=1:m
        for jj = 1:nParam
            if jj == 1
                a_temp(j,1) = bin2dec(gray2bin(dec2bin(bin2dec(num2str(A(j,1:nBitParam))))));
            else
                a_temp(j,jj) = bin2dec(gray2bin(dec2bin(bin2dec(num2str(A(nBitParam*(jj-1)+1:nBitParam*(jj+1)))))));
            end
        end
    end
    if nParam == 1
        [val,idx] = min(a_temp);
        a_kand = a_temp(idx)/scale;
        eval_kand = Rastriginf(a_kand);
        eval_opt =Rastriginf(a_opt);
    end
    if nParam == 2
        for i=1:nParam
            a_kand(1,nParam) = min(a_temp(:,nParam));
        end
        eval_kand = RBfun(a_kand(1,1),a_kand(1,2),a,b);
        eval_opt =RBfun(a_opt(1,1),a_opt(1,2),a,b);
    end
    if eval_opt > eval_kand
    else
        break
    end
end
found_min = eval_opt

%% Plot
%Rast
for i =1:length(x)
        y(i) = Rastriginf(x(i));
end
plot(x,y)
hold on
plot(a_opt,Rastriginf(a_opt),'rx')

% Rb
%for i=1:length(x_rb)
%   for j=1:length(y_rb)
%        z(i,j) = RBfun(x_rb(i),y_rb(j),a,b);
%    end
%end
%contour(x_rb,y_rb,z', [0.05, 2, 10, 75, 333, 1666], 'color', [0 0 0], 'linewidth',1.5)
%hold on
%plot3(a_opt(1,1),a_opt(1,2),RBfun(a_opt(1,1),a_opt(1,2),a,b),'rx')

%% Functions

function y = Rastriginf(x)
    n = length(x);
    y = 10*n + sum(x.^2 - 10*cos(2*pi*x));    
end

function z = RBfun(x,y,a,b)
    z = (a-x)^2 + b*(y-x^2)^2;
end

function g = bin2gray(b)
% not used, but just in case
    g(1) = b(1);
    for i = 2 : length(b)
        x = xor(str2double(b(i-1)), str2double(b(i)));
        g(i) = num2str(x);
    end
    
end
function b = gray2bin(g)
    b(1) = g(1);
    for i = 2 : length(g)
        x = xor(str2double(b(i-1)), str2double(g(i)));
        b(i) = num2str(x);
    end
end

 