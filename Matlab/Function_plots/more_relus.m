clear;clc;clf;

x = linspace(-10,10);
y = ELU(x);
plot(x,y)
xlabel("X")
ylabel("Y")
hold on
grid on
title("Přiklady variant ReLU")


y2 = SELU(x);
plot(x,y2)

y3 = SiLU(x);
plot(x,y3,'g')

y4 = SoftPlus(x);
plot(x,y4,'k')

legend('ELU','SELU', "SiLU", "Softplus")



function [y] = ELU(x, aplha)

    if ~exist('aplha','var')
    % second parameter does not exist, so default it to something
    aplha = 1;
    end
    y = zeros(length(x),0);
    if length(x) <= 1
        return
    end
    for i=1:length(x)
        if x(i) <= 0
           y(i) = aplha*(exp(x(i))-1);
        else 
            y(i) = x(i);
        end
    end
end

function [y] = SELU(x, aplha, lambda)

    if ~exist('aplha','var')
    % second parameter does not exist, so default it to something
    aplha = 1.6732632423543772848170429916717;
    end

    if ~exist('lambda','var')
    % second parameter does not exist, so default it to something
    lambda = 1.0507009873554804934193349852946;
    end

    y = zeros(length(x),0);
    if length(x) <= 1
        return
    end
    for i=1:length(x)
        if x(i) <= 0
           y(i) = lambda*aplha*(exp(x(i))-1);
        else 
            y(i) = lambda*x(i);
        end
    end
end

function [y] = SiLU(x)
    y = zeros(length(x),0);
    sigmoid_f = @(x) 1./(1+exp(-x));
    if length(x) <= 1
            return
    end
    for i=1:length(x)
        y(i) = x(i) * sigmoid_f(x(i));
    end
end

function [y] = SoftPlus(x)
    y = zeros(length(x),0);
    if length(x) <= 1
            return
    end
    for i=1:length(x)
        y(i) = log(1 + exp(x(i)));
    end
   
end
