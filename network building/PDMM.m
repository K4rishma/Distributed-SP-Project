function [err, x]=PDMM(kmax, G, x, x_ave, A)
%compute A matrix baed on adjacency matrix
for i=1:200
    for j=1:200
        if i<j
            A(i,j)=-A(i,j);
        else
            continue
        end
    end
end

%parameter setting 
c=0.4;
d=degree(G);
lambda=1*ones(200,200);
i=zeros(0,1);
k=0;
err=inf;

%iteration
while(err(end)>1e-12) && (k<kmax)
    %select a node randomly
    i(end+1)=randi(200);
    nei=neighbors(G, i(end));
    A_nei=A(i(end), nei);
    lam=lambda(nei, i(end));
    
    %update the node value
    x(i(end))=(x_ave+A_nei*lam+c*abs(A_nei)*x(nei))/(1+c*d(i(end)));
    lambda(i(end),nei)=lambda(nei,i(end))'-c.*A_nei.*(x(i(end))-x(nei))';
    
    %compute the iteration error
    k=k+1;
    err(k)=norm(x-x_ave);
    
end