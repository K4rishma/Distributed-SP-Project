close all
clear all
clc
n = 168; % node number
d = zeros (n ,1); %
err = inf;
err2 = inf;
k = 0;
kmax_n = 600000;
A = zeros (n,n);
%% node value initialization
a = 1:1:12; %x
b = 1:1:14; %y
x = zeros (n ,1) ; % node value
for i = 1:1: n
x(i) = normrnd (20 ,1);
end
x_ave = (sum(x)/n)* ones (n ,1);
%% degree initialization
d = 3* ones (n ,1) ;
bb = [1 14];
for i = 1:1:2
for a = 1:1:12
z = (bb(i) -1) *12+ a;
d(z) = 2;
end
end
bb1 = [4 5 8 9 12 13];
bb2 = [2 3 6 7 10 11];
for i = 1:1:6
a = 1;
z = (bb1(i) -1) *12+ a;
d(z) = 2;
a = 12;
z = (bb2(i) -1) *12+ a;
d(z) = 2;
end
d(1) =1;
d (168) =1;
%% adjacency initialzation
% b=1, a=1
z_i = 1; z_o = 13;
A(z_i ,z_o) = 1;
% b=1, a=2 -12
b_i = 1;
for a_i = 2:1:12;
z_i = 12*( b_i -1)+a_i;
z_o1 = 12* b_i+a_i -1;
z_o2 = 12* b_i+a_i;
A(z_i , z_o1 ) = 1;
A(z_i , z_o2 ) = 1;
end
% b=14 , a=1 -11
b_i = 14;
for a_i = 1:1:11;
z_i = 12*( b_i -1)+a_i;
z_o1 = 12* b_i+a_i -24;
z_o2 = 12* b_i+a_i -23;
A(z_i , z_o1 ) = 1;
A(z_i , z_o2 ) = 1;
end
% b=14 , a=12
z_i = 168; z_o = 156;
A(z_i ,z_o) = 1;
%b=2, a=1 -11
bbb = [2 6 10];
for i = 1:1:3
for a_i = 1:1:11
z_i = (bbb (i) -1) *12+ a_i;
z_o1 = 12* bbb (i)+a_i -24;
z_o2 = 12* bbb(i)+a_i -23;
z_o3 = 12* bbb(i)+a_i;
A(z_i , z_o1 ) = 1;
A(z_i , z_o2 ) = 1;
A(z_i , z_o3 ) = 1;
end
end
%b=2,a=12
a_i =12;
for i = 1:1:3
z_i = (bbb (i) -1) *12+ a_i;
z_o1 = 12* bbb (i)+a_i -24;
z_o2 = 12* bbb(i)+a_i;
A(z_i , z_o1 ) = 1;
A(z_i , z_o2 ) = 1;
end
%b=3,a=1 -11
bbb = [3 7 11];
for i = 1:1:3
for a_i = 1:1:11
z_i = (bbb (i) -1) *12+ a_i;
z_o1 = 12* bbb (i)+ a_i;
z_o2 = 12* bbb(i)+a_i +1;
z_o3 = 12* bbb(i)+a_i -24;
A(z_i , z_o1 ) = 1;
A(z_i , z_o2 ) = 1;
A(z_i , z_o3 ) = 1;
end
end
%b=3,a=12
a_i =12;
for i = 1:1:3
z_i = (bbb (i) -1) *12+ a_i;
z_o1 = 12* bbb(i)+a_i -24;
z_o2 = 12* bbb(i)+a_i;
A(z_i , z_o1 ) = 1;
A(z_i , z_o2 ) = 1;
end
%b=4,a=2 -12
bbb = [4 8 12];
for i = 1:1:3
for a_i = 2:1:12
z_i = (bbb (i) -1) *12+ a_i;
z_o1 = 12* bbb(i)+a_i -25;
z_o2 = 12* bbb(i)+a_i -24;
z_o3 = 12* bbb(i)+a_i;
A(z_i , z_o1 ) = 1;
A(z_i , z_o2 ) = 1;
A(z_i , z_o3 ) = 1;
end
end
%b=4,a=1
a_i =1;
for i = 1:1:3
z_i = (bbb (i) -1) *12+ a_i;
z_o1 = 12* bbb(i)+a_i -24;
z_o2 = 12* bbb(i)+a_i;
A(z_i , z_o1 ) = 1;
A(z_i , z_o2 ) = 1;
end
%b=5,a=2 -12
bbb = [5 9 13];
for i = 1:1:3
for a_i = 2:1:12
z_i = (bbb (i) -1) *12+ a_i;
z_o1 = 12* bbb(i)+a_i -24;
z_o2 = 12* bbb(i)+a_i -1;
z_o3 = 12* bbb(i)+a_i;
A(z_i , z_o1 ) = 1;
A(z_i , z_o2 ) = 1;
A(z_i , z_o3 ) = 1;
end
end
%b=5,a=1
a_i =1;
for i = 1:1:3
z_i = (bbb (i) -1) *12+ a_i;
z_o1 = 12* bbb(i)+a_i -24;
z_o2 = 12* bbb(i)+a_i;
A(z_i , z_o1 ) = 1;
A(z_i , z_o2 ) = 1;
end
%% randomized gossip
xx = x;
errr = zeros (kmax_n ,1);
kmax = kmax_n ;
while (err(end) > 1e-12) && (k < kmax )
i = randi (n);
nnn = find (A(i ,:) ==1) ;
[V D] = size (nnn);
pos = unidrnd (D);
j = nnn(pos);
x([i j]) = .5* sum(x([i j]));
k = k+1;
err(k) = norm (x- x_ave );
end
plot ( log10 (err),'r')
hold on
xlabel ('kmax');
ylabel ('error (dB)');