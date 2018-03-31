function [err, x]=greedy_gossip(kmax, G, x, x_ave)
%iterate utill convergence
k=0;
err=inf;
d=degree(G);
i=zeros(0,1);
while(err(end)>1e-12) && (k<kmax)
    
   %select nodes randomly
   i(end+1)=randi(200);
   nei=neighbors(G,i(end));
   diff=abs(x(nei)-x(i(end)));
   [Y I]=max(diff);
   j=nei(I);
   
   %update nodes
   x([i(end) j])=.5*sum(x([i(end) j]));
   
   %compute estimation error
   k=k+1;
   err(k)=norm(x-x_ave);
end