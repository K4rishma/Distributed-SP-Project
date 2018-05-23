clear all
clc
close all
%% generate the coordinates
x=1.5:3:60;
x=repmat(x,[1,10]);
y1=ones(1,20)*1.5;
y2=y1+3;
y3=y2+3;
y4=y3+3;
y5=y4+3;
y6=y5+3;
y7=y6+3;
y8=y7+3;
y9=y8+3;
y10=y9+3;
y=[y1, y2, y3, y4, y5, y6, y7,y8,y9,y10];
%% scatter the sensors
scatter(x,y,'.r');
hold on 
% draw the transmission region
for i=30
    rectangle('Position',[x(i)-4,y(i)-4,8,8],'Curvature',[1,1]);
end
hold on
%% draw the plant
rectangle('Position',[0,0,60,30])
axis equal
title('sensor network')
xlabel('w/(m)')
ylabel('h/(m)')
axis([0 60 0 30])

