function [err, x]=tr_randomized_gossip(kmax, G, x, x_ave, threshold)
%iterate utill convergence
k=0;
err=inf;
d=degree(G);
i=zeros(0,1);
while(err(end)>1e-12) && (k<kmax)
    
   %select nodes randomly
   i(end+1)=randi(200);
   nei=neighbors(G,i(end));
   j=nei(randi(d(i(end))));
   trf=rand(1)>threshold;
   if trf==1
       
       %update nodes
       x(i(end))=.5*sum(x([i(end) j]));
        trf=rand(1)>threshold;
        if trf==1
            x(j)=x(i(end));
        end
   end
            
   
   %compute estimation error
   k=k+1;
   err(k)=norm(x-x_ave);
end