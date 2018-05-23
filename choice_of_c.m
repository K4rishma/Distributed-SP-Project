close all
clc
clear all
temp=20;
sigma=1;
kmax=1e6;
[A,G]=Adjacency_matrix(20,10);
N=190;
nd=randi(200,[10 1]); %consider 5% failure
G=rmnode(G,nd);
x_initial=normrnd(temp ,sigma, [N,1]);
x_ave=mean(x_initial);
s=zeros(0,1);
% threshold=0.05;
for c=0:0.5:4
    [err, k]=PDMM(kmax, G, x_initial, x_ave, A, c, N);
     s(end+1)=k;
end
%%
 c=0:0.5:4
plot(c,s)
title('4-Regular Grid Topology, n=200, p=0.2');
xlabel('-c');
ylabel('number of iterations');
text(3.5, 90000,'||x(k)-x_{ave}||<10^{-12}');