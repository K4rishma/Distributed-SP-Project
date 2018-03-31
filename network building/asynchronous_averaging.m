function [err, x] = asynchronous_averaging(kmax, G, x, x_ave)
% iterate until convergence
k=0;
err=inf;
d=degree(G);
i=zeros(0,1);
while(err(end)>1e-12) && (k<kmax)
    %select node randmly
    i(end+1)=randi(200);
    nei=neighbors(G, i(end));
    
    %update node
    x([i(end); nei])=sum(x([i(end);nei]))/(d(i(end))+1);
    
    %compute the iteration error
    k=k+1;
    err(k)=norm(x-x_ave);
end