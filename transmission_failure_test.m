close all
clc
clear all
temp=20;
sigma=1;
kmax=1e10;
c=0.4;
threshold=0.3;
x_initial=normrnd(temp ,sigma, [200,1]);
x_ave=mean(x_initial);
[A,G]=Adjacency_matrix(20,10);
for n=1:1
%% asynchronous_averaging
[err2(n,:), x2]=tr_asynchronous_averaging(kmax, G, x_initial, x_ave, threshold);
l2=length(err2);
%% randomized_gossip
[err1(n,:), x1]=tr_randomized_gossip(kmax, G, x_initial, x_ave, threshold);
l1=length(err1);
%% greedy_gossip
[err3(n,:), x3]=tr_greedy_gossip(kmax, G, x_initial, x_ave, threshold);
l3=length(err3);
%% broadcast_gossip
[err4(n,:), x4]=tr_broadcast_gossip(kmax, G, x_initial, x_ave, threshold);
l4=length(err4);
%% PDMM
[err5(n,:), k]=tr_PDMM(kmax, G, x_initial, x_ave, A, c, threshold);
l5=length(err5);
%% sum-weight_gossip
[err6(n,:), x6]=tr_sum_weight_gossip(kmax, G, x_initial, x_ave, threshold);
l6=length(err6);
%%
n=n+1;
end
err1=mean(err1,1);
err2=mean(err2,1);
err3=mean(err3,1);
err4=mean(err4,1);
err5=mean(err5,1);
err6=mean(err6,1);
%% experimental results
figure(1);
plot (1:l2, err2,'c', 1:l1, err1,  'r', 1:l3, err3, 'k', 1:l6, err6, 'b', 1:l4, err4, 'g', 1:l5, err5, 'm', 'LineWidth', 1);
xlabel ('number of iterations');
ylabel ('||x(k)-x_{ave}*1||');
legend('asynchronous distributed averaging', 'randomized gossip',  'greedy gossip with eavesdropping', 'sum-weight gossip', 'broadcast weighted gossip', 'PDMM(c=-0.4)');
title('4-Regular Grid Topology, n=200, p=0.3');
grid on;
set(gca,'yscale','log');
%axis([0 4e5 1e-3 1e2])
% figure(2)
% plot (1:200, x_initial, '--m', 1:200, x2,'c', 1:200,x1,  'r', 1:200,x3, 'k', 1:200,x6, 'b', 1:200, x4, 'g', 'LineWidth', 0.5);
% axis([1 100 19.5 20.5])