function [err, k]=tr_PDMM(kmax, G, x, x_ave, A, c, threshold)
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
d=degree(G);
lambda=1*ones(200,200);
i=zeros(0,1);
k=0;
err=inf;
x_initial=x;


%iteration
while(err(end)>1e-12) && (k<kmax)
    %select a node randomly
    i(end+1)=randi(200);
    nei=neighbors(G, i(end));
    trf=rand([d(i(end)), 1])>threshold;%model the transmission failure
    nei=nei(find(trf==1));
    dd=length(nei);
    if dd~=0
        A_nei=A(i(end), nei);
        lam=lambda(nei, i(end));

        %update the node value
        x(i(end))=(x_initial(i(end))+A_nei*lam+c*abs(A_nei)*x(nei))/(1+c*dd);
        lambda(i(end),nei)=lambda(nei,i(end))'-c.*A_nei.*(x(i(end))-x(nei))';
    end
    %compute the iteration error
    k=k+1;
    err(k)=norm(x-x_ave);
    
end