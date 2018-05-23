function [err, x] = tr_asynchronous_averaging(kmax, G, x, x_ave, threshold)
% iterate until convergence
k=0;
err=inf;
d=degree(G);
i=zeros(0,1);
while(err(end)>1e-12) && (k<kmax)
    %select node randmly
    i(end+1)=randi(200);
    nei=neighbors(G, i(end));
    trf=rand([d(i(end)), 1])>threshold;% transmission failure from node j
    nei=nei(find(trf==1));
    dd=length(nei);
    %update node
     x(i(end))=sum(x([i(end);nei]))/(dd+1);
    if dd~=0
        trf=rand([dd, 1])>threshold;%transmission failure from noe i
        nei=nei(find(trf==1));
        dd=length(nei);
        if dd~=0
            x([nei])=x(i(end));
        end
    end
    %compute the iteration error
    k=k+1;
    err(k)=norm(x-x_ave);
end