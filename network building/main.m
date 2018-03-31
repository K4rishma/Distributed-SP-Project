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
%% experimental results
figure(1);
plot (1:l1, log10(err1), 'r', 1:l2, log10(err2), 'b')
xlabel ('transmissions');
ylabel ('||x(k)-x_(ave)*1||');
legend('randomized gossip', 'asynchronous averaging');
