clc;
clear;
%% 输入相应参数，调用画图函数画三维图
xmin = 6.7; %X轴的最小值
xmax = 9.15; %X轴的最大值
ymin = 0.35; %y轴的最小值
ymax = 5;   %y轴的最大值
draw_picture(xmin,xmax,ymin,ymax);

%% 输入相应参数，调用粒子群算法，所有参数都必须输入
N = 100 ; %　种群规模
D = 2 ; % 粒子维度
T = 1000 ; %　迭代次数
C1 = 1.5 ; %　学习因子1
C2 = 1.5 ; %　学习因子2
W = 0.8 ; %　惯性权重
Xmin = 6.7 ;% X坐标的最小值
Xmax = 9.15 ;% X坐标的最大值
Ymin =0.35;% Y坐标的最小值
Ymax =5 ;% Y坐标的最大值
Vmax = 3 ; %　最大飞行速度
Vmin = -3 ; %　最小飞行速度
%调用粒子群算法
pso(N,D,T,C1,C2,W,Xmin,Xmax,Ymin,Ymax,Vmin,Vmax);

