
function [outputs] = vsc_net(xs,ys,n)

    n=200;
    xs = linspace(0,10, n);
    ys = linspace(0,10, n);
    %[Xs,Ys] = meshgrid(xs,ys)
    %f = @(xx) Langermann_fce(xx);
    %for i=1:n
    %    for j=1:n
    %        Zs(i,j) = f([Xs(i,j),Ys(i,j)]);
    %    end
    %end
    
    %meshc(Xs, Ys, Zs)
    
    XY = rand(n, 2)*2-1;
    %[Xst,Yst] = meshgrid(XY(:,1),XY(:,2));
    
    neurons = [100];
    net = fitnet(neurons,"trainscg");
    xys = [xs; ys]';
    trained_net = train(net,XY.',xys');
    
    outputs = (trained_net(XY'))'
    [Xst,Yst] = meshgrid(outputs(:,1),outputs(:,2));
    f = @(xx) Langermann_fce(xx);
    for i=1:n
        for j=1:n
            Zs(i,j) = f([Xst(i,j),Yst(i,j)]);
        end
    end
    %meshc(Xst,Yst,Zs)

end