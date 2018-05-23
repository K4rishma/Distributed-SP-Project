function [err, x]=tr_sum_weight_gossip(kmax, G, s, x_ave, threshold)
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
     j=nei(randi(d(i(end))));
    trf=rand(1)>threshold;
    if trf==1
        %update sum vector
        s(i(end))=s(i(end))/2;
        

        %update the weight vector
        w(i(end))=w(i(end))/2;
        trf=rand(1)>threshold;
        if trf==1
            s(j)=s(j)+s(i(end));
            w(j)=w(j)+w(i(end));
        end
    end

        %update the node value
        x=s./w;
    
    %compute the iteration error
    k=k+1;
    err(k)=norm(x-x_ave);
end