close all
clc
clear all
temp=20;
sigma=1;
kmax=6e5;
x_initial=normrnd(temp ,sigma, [200,1]);
x_ave=mean(x_initial);
G=Adjacency_matrix(20,10);
%% randomized_gossip
[err1, x1]=randomized_gossip(kmax, G, x_initial, x_ave);
l1=length(err1);
%% asynchronous_averaging
[err2, x2]=asynchronous_averaging(kmax, G, x_initial, x_ave);
l2=length(err2);
%% greedy_gossip
[err3, x3]=greedy_gossip(kmax, G, x_initial, x_ave);
l3=length(err3);
%% broadcast_gossip
[err4, x4]=broadcast_gossip(kmax, G, x_initial, x_ave);
l4=length(err4);
%% experimental results
figure(1);
plot (1:l1, log10(err1), 'r', 1:l2, log10(err2), 'b', 1:l3, log10(err3), 'k', 1:l4, log10(err4), 'g');
xlabel ('transmissions');
ylabel ('||x(k)-x_(ave)*1||');
legend('randomized gossip', 'asynchronous averaging', 'greedy gossip with eavesdropping', 'broadcast weighted gossip');
