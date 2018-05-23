function [err, x]=randomized_gossip(kmax, G, x, x_ave,N)
%iterate utill convergence
k=0;
err=inf;
d=degree(G);
i=zeros(0,1);
while(err(end)>1e-12) && (k<kmax)
    
   %select nodes randomly
   i(end+1)=randi(N);
   nei=neighbors(G,i(end));
   j=nei(randi(d(i(end))));

   
   %update nodes
   x([i(end) j])=.5*sum(x([i(end) j]));
   
   %compute estimation error
   k=k+1;
   err(k)=norm(x-x_ave);
end