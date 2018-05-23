function [err, x]=tr_greedy_gossip(kmax, G, x, x_ave, threshold)
%iterate utill convergence
k=0;
err=inf;
d=degree(G);
i=zeros(0,1);
while(err(end)>1e-12) && (k<kmax)
    
   %select nodes randomly
   i(end+1)=randi(200);
   nei=neighbors(G,i(end));
   trf=rand([d(i(end)), 1])>threshold;%model the transmission failure from node j
   nei=nei(find(trf==1));
   dd=length(nei);
   if dd~=0
       diff=abs(x(nei)-x(i(end)));
       [Y I]=max(diff);
       j=nei(I);

       %update nodes
       x(i(end))=.5*sum(x([i(end) j]));
       trf=rand(1)>threshold;%transmission failure form node i
       if trf==1
           x(j)=x(i(end));
       end
   end
   %compute estimation error
   k=k+1;
   err(k)=norm(x-x_ave);
end