close all
clc
clear all
temp=20;
sigma=1;
kmax=1e6;
c=2.5;
x_initial=normrnd(temp ,sigma, [200,1]);
x_ave=mean(x_initial);
[A,G]=Adjacency_matrix(20,10);
%% asynchronous_averaging
[err2, x2]=asynchronous_averaging(kmax, G, x_initial, x_ave);
l2=length(err2);
%% randomized_gossip
[err1, x1]=randomized_gossip(kmax, G, x_initial, x_ave);
l1=length(err1);
%% greedy_gossip
[err3, x3]=greedy_gossip(kmax, G, x_initial, x_ave);
l3=length(err3);
%% broadcast_gossip
[err4, x4]=broadcast_gossip(kmax, G, x_initial, x_ave);
l4=length(err4);
%% PDMM
[err5, k]=PDMM(kmax, G, x_initial, x_ave, A, c);
l5=length(err5);
%% sum-weight_gossip
[err6, x6]=sum_weight_gossip(kmax, G, x_initial, x_ave);
l6=length(err6);
%% experimental results
figure(1);
plot (1:l2, err2,'c', 1:l1, err1,  'r', 1:l3, err3, 'k', 1:l6, err6, 'b', 1:l4, err4, 'g', 1:l5, err5, 'm', 'LineWidth', 1);
xlabel ('number of iterations');
ylabel ('||x(k)-x_{ave}*1||');
legend('asynchronous distributed averaging', 'randomized gossip',  'greedy gossip with eavesdropping', 'sum-weight gossip', 'broadcast weighted gossip', 'PDMM(c=-2.5)');
% axis('YMIN', 1e-12);
title('4-Regular Grid Topology, n=200');
grid on;
set(gca,'yscale','log');
