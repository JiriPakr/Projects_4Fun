clear;clc;
%function [outputs] = vsc_net(xs,ys,n)

    % Training data
    n_train = 2000;
    x_train = linspace(0,10, n_train);
    y_train = linspace(0,10, n_train);
    x_trainrnd = rand(1,n_train)*10;
    y_trainrnd = rand(1,n_train)*10;

    % Testing data
    n_test = 200;
    x_test = linspace(0,10, n_test);
    y_test = linspace(0,10, n_test);

    % Ploting data
    n_ploting = 20;
    x_p = linspace(0,10, n_ploting);
    y_p = linspace(0,10, n_ploting);
    [X_p,Y_p] = meshgrid(x_p,y_p);
    f = @(xx) Langermann_fce(xx);
    for i=1:n_ploting
        for j=1:n_ploting
            Z_p(i,j) = f([X_p(i,j),Y_p(i,j)]);
        end
    end

    subplot(2,1,1)
    meshc(X_p, Y_p, Z_p)
    

    %XY = rand(n, 2)*2-1;
    %[Xst,Yst] = meshgrid(XY(:,1),XY(:,2));
    
    hiddenLayerSize = [20];
    net = fitnet([hiddenLayerSize,hiddenLayerSize],"trainscg");
    net.trainParam.max_fail = 1000;
    net.trainParam.epochs=10000;
    % net.trainParam.min_grad=1e-10;
    % net.trainParam.show=10;
    % net.trainParam.lr=0.01;
    % net.trainParam.goal=0.001;`


    X_train = [x_train; y_train]';
    X_trainrnd = [x_trainrnd; y_trainrnd]';
    X_train = [X_train;X_trainrnd];

    for i=1:length(X_train)
        Y_train(i,1) = f([X_train(i,1),X_train(i,2)]);
    end
    X_test = [x_test; y_test]';
    for i=1:length(X_test)
        Y_test(i,1) = f([X_test(i,1),X_test(i,2)]);
    end

    training_input = X_train';
    training_target = Y_train';
    %[net,tr] = train(net, training_input, training_target);
    %training_output = net(training_input);
    load trained_net
    net = trained_net;

    testing_input = X_test';
    testing_target = Y_test';

    [X_out,Y_out] = meshgrid(testing_input(1,:),testing_input(2,:));
    for i=1:length(X_out)
        for j=1:length(Y_out)
            Z_out(i,j) = sim(net, [X_out(i,j),Y_out(i,j)]');
        end
    end
  
    subplot(2,1,2)
    meshc(X_out, Y_out, Z_out)
%end