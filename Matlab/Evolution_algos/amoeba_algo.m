clear;clc;clf;
%% Parameters
x = linspace(-2,2,300);
y = linspace(-1,3,300);
z = zeros(length(x),length(y));
a = 1;
b = 100;

alpha = 1;
gamma = 2;
rho = 1/4;
sigma = 1/2;

%% Plot
for i=1:length(x)
    for j=1:length(y)
        z(i,j) = RBfun(x(i),y(j),a,b);
    end
end

contour(x,y,z', [0.05, 2, 10, 75, 333, 1666], 'color', [0 0 0], 'linewidth',1.5)
hold on
%s = surf(x,y,z);
%s.LineStyle = 'None';
%% Tringle ploting
% point inicialization like -> point = [x,y,evaluantion]
p_0 = [-1,0,0];         
q_0 = [0,0,0];
r_0 = [-1,1,0];
points(1,:) = p_0;
points(2,:) = q_0;
points(3,:) = r_0;

% plots

% same as:
%plot([p_0(1),q_0(1)],[p_0(2),q_0(2)],"r")
%plot([p_0(1),r_0(1)],[p_0(2),r_0(2)],"r")
%plot([p_0(1),q_0(1)],[r_0(2),q_0(2)],"r")

%% Main function
for iter = 1:100
    plot([points(1,1),points(2,1)],[points(1,2),points(2,2)], 'r')
    plot([points(1,1),points(3,1)],[points(1,2),points(3,2)], 'r')
    plot([points(1,1),points(2,1)],[points(3,2),points(2,2)], 'r')
    for i = 1:size(points,1)
        points(i,3) = RBfun(points(i,1),points(i,2),a,b);
        % same as:
        %p_0(3) = RBfun(p_0(1),p_0(2),a,b);
        %q_0(3) = RBfun(q_0(1),q_0(2),a,b);
        %r_0(3) = RBfun(r_0(1),r_0(2),a,b);
    end                
    % sort in ascending order, best first
    points = sortrows(points,3);  %points = sortrows(points,3,'descend');
    % calc centroid for 2 best (lowest) points
    centroid = (points(1,1:2)+points(2,1:2))/2;

    % reflection
    reflection = centroid + alpha*(centroid-points(3,1:2));
    reflection(3) = RBfun(reflection(1),reflection(2),a,b);
    if reflection(3) < points(2,3) && reflection(3) >= points(1,3)
        points(3,:) = reflection;
        disp("Reflection");
        continue

    % expansion     
    elseif reflection(3) < points(1,3)
        expansion = centroid + gamma*(reflection(1:2)-centroid);
        expansion(3) = RBfun(expansion(1),expansion(2),a,b);
        if expansion(3) < reflection(3)
            points(3,:) = expansion;
            disp("Expansion");
            continue
        else
            points(3,:) = reflection;
            disp("Reflection2");
            continue
        end
    end
    % contraction
    contraction = centroid + rho*(reflection(1:2) - centroid);
    contraction(3) = RBfun(contraction(1),contraction(2),a,b);
    if contraction(3) < reflection(3)
        points(3,:) = contraction;
        disp("contraction");
        continue
    end
   
   %shrink
    for j=2:size(points,1)
       points(j,1) = points(1,1) + sigma*(points(j,1)-points(1,1));
       points(j,2) = points(1,2) + sigma*(points(j,2)-points(1,2));
    end
    disp("Shrink")
end
%% Other functions
function z = RBfun(x,y,a,b)
    z = (a-x)^2+b*(y-x^2)^2;
end