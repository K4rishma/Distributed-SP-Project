function [err, k]=PDMM(kmax, G, x, x_ave, A, c,N)
%compute A matrix baed on adjacency matrix
for i=1:N
    for j=1:N
        if i<j
            A(i,j)=-A(i,j);
        else
            continue
        end
    end
end

%parameter setting 
d=degree(G);
lambda=1*ones(N,N);
i=zeros(0,1);
k=0;
err=inf;
x_initial=x;

%iteration
while(err(end)>1e-12) && (k<kmax)
    %select a node randomly
    i(end+1)=randi(N);
    nei=neighbors(G, i(end));
    A_nei=A(i(end), nei);
    lam=lambda(nei, i(end));
    
    %update the node value
    x(i(end))=(x_initial(i(end))+A_nei*lam+c*abs(A_nei)*x(nei))/(1+c*d(i(end)));
    lambda(i(end),nei)=lambda(nei,i(end))'-c.*A_nei.*(x(i(end))-x(nei))';
    
    %compute the iteration error
    k=k+1;
    err(k)=norm(x-x_ave);
    
end