function [err, x] = tr_broadcast_gossip(kmax, G, s, x_ave, threshold)
% iterate until convergence
k=0;
err=inf;
d=degree(G);
i=zeros(0,1);
w=ones(200,1);%initialize the weight vector
x=zeros(200,1);
while(err(end)>1e-12) && (k<kmax)
    %select node randmly
    i(end+1)=randi(200);
    nei=neighbors(G, i(end));
    trf=rand([d(i(end)), 1])>threshold;% transmission failure form node j
    nei=nei(find(trf==1));
    dd=length(nei);
   
    %update sum vector
    s(i(end))=s(i(end))/(d(i(end))+1);
    
    %update the weight vector
    w(i(end))=w(i(end))/(d(i(end))+1);
    
    %if transmissions all fail, no neighbouring nodes update w and s
    if dd~=0
        trf=rand([dd, 1])>threshold;
        nei=nei(find(trf==1));
        dd=length(nei);
        if dd~=0         
            s(nei)=s(nei)+s(i(end));
            w(nei)=w(nei)+w(i(end));
        end
    end
    
    %update the node value
    x=s./w;
    
    %compute the iteration error
    k=k+1;
    err(k)=norm(x-x_ave);
end