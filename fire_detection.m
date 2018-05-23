clear all
close all
temp=20;
sigma=20
for N=1:10
    x(N,:)=normrnd(temp ,sigma, [200,1]);
end
%% nodes within fire region
F=[10,29,30,31,50];
for N=1:10
    x(N, [F])=x(N,[F])+60;
end
%% decision rule 
T=mean(x,1);
fire_regin=find(T>50)
    