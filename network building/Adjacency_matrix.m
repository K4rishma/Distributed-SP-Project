function G=Adjacency_matrix(m,n)
    size=(m+2)*(n+2);
    A=zeros(size,size);
    B=zeros(0,1);
    for i=2+m:size-m-3
            if rem(i,22)==1
                continue
            elseif rem(i,22)==0
                continue
            else
                A(i,[i-1,i+1,i+22,i-22])=1;
                B(end+1)=i;
            end
    end
    A=A(B,B);
    G=graph(A);
    neighbors(G,22)
end