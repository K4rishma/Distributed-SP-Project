function [err, x]=sum_weight_gossip(kmax, G, s, x_ave, N)
% iterate until convergence
k=0;
err=inf;
d=degree(G);
i=zeros(0,1);
w=ones(N,1);%initialize the weight vector
x=zeros(N,1);
while(err(end)>1e-12) && (k<kmax)
    %select node randmly
    i(end+1)=randi(N);
    nei=neighbors(G, i(end));
     j=nei(randi(d(i(end))));
    
    %update sum vector
    s(i(end))=s(i(end))/2;
    s(j)=s(j)+s(i(end));
    
    %update the weight vector
    w(i(end))=w(i(end))/2;
    w(j)=w(j)+w(i(end));
    
    %update the node value
    x=s./w;
    
    %compute the iteration error
    k=k+1;
    err(k)=norm(x-x_ave);
end