x = linspace(-15,-5,100);
y = linspace(-3,3,100);
z = zeros(length(x), length(y));

for i = 1:length(x)
    for ii = 1:length(y)
        z(i,ii) = bukinn6(x(i),y(ii));
    end
end

s = surf(x,y,z);
s.LineStyle = 'None';
xlabel("X")
ylabel("Y")
zlabel("Z")
title("Bukin n.6 function")


function [z] = bukinn6(x,y)
    z = 100*sqrt(abs(y-0.01*x^2))+0.01*abs(x+10);    
end