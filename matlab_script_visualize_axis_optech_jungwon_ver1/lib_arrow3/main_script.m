%
% arrow3 example
%   displaying only initial point marker

clc;
clear all;
close all;

figure(1);

daspect([1 1 2]), view([-40,24])
axis([-1 4 -1 4 0 6])
hold on, 

p1=[2, 1, 0];
p2=[-1, 2, 6];

w=[0]; h=[0]; ip=[3];

arrow3(p1,p2,'o-',w,h,ip)

%hold off

p1=[5, 2, 1];
p2=[0, 1, 2];

arrow3(p1,p2,'o-',w,h,ip)


camlight left
