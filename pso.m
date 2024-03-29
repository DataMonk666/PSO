function  pso(N,D,T,C1,C2,W,Xmin,Xmax,Ymin,Ymax,Vmin,Vmax)
%%  各参数代表的意思
%       N :种群规模
%       D :粒子维度
%       T :迭代次数
%       C1:学习因子1
%       C2 :学习因子2
%       W :惯性权重
%       Xmin  ：X坐标的最小值
%       Xmax  ：X坐标的最大值
%       Ymin  ：Y坐标的最小值
%       Ymax  ：Y坐标的最大值
%       Vmin　：最小飞行速度
%       Vmax  ：最大飞行速度

%%  初始化粒子群的位置和速度
%popx = rand(N,D)*(Xmax-Xmin)+Xmin ; % 初始化粒子群的位置(粒子位置是一个D维向量)
X = rand(N,1)*(Xmax-Xmin)+Xmin;
Y = rand(N,1)*(Ymax-Ymin)+Ymin;
popx = [X Y];
popv = rand(N,D)*(Vmax-Vmin)+Vmin ; % 初始化粒子群的速度(粒子速度是一个D维度向量) 

%%  个体极值和群体极值
% 初始化每个历史最优粒子
pBest = popx ; 
pBestValue = func_fitness(pBest) ; 
%初始化全局历史最优粒子
[gBestValue,index] = max(func_fitness(popx)) ;
gBest = popx(index,:) ;

%%  迭代寻优
for t=1:T
    for i=1:N
        % 更新个体的位置和速度
        popv(i,:) = W*popv(i,:)+C1*rand*(pBest(i,:)-popx(i,:))+C2*rand*(gBest-popx(i,:)) ;
        popx(i,:) = popx(i,:)+popv(i,:) ;
        % 边界处理，超过定义域范围就取该范围极值
        index = find(popv(i,:)>Vmax | popv(i,:)<Vmin);
        popv(i,index) = rand*(Vmax-Vmin)+Vmin ; %#ok<*FNDSB>
        %index = find(popx(i,:)>Xmax | popx(i,:)<Xmin);
        %popx(i,index) = rand*(Xmax-Xmin)+Xmin ;
        aa = popx(i,:);
        if aa(1)>Xmax || aa(1)<Xmin
             popx(i,1) = rand*(Xmax-Xmin)+Xmin;
        end
        if aa(2)>Ymax || aa(2)<Ymin
             popx(i,2) = rand*(Ymax-Ymin)+Ymin;
        end
        
        % 更新粒子历史最优
        if func_fitness(popx(i,:))>pBestValue(i)    
           pBest(i,:) = popx(i,:) ;
           pBestValue(i) = func_fitness(popx(i,:));
        end
       if pBestValue(i) > gBestValue
            gBest = pBest(i,:) ;
            gBestValue = pBestValue(i) ;
       end
    end
    tBest(t) = func_fitness(gBest);
    % 每代最优解对应的目标函数值
    %tBest(t) = func_objValue(gBest); %#ok<*SAGROW>
    %tBest(t) = func_fitness(gBest);
end

%% 结果输出
%输出最优解对应的坐标位置
str=['the postition of max_value is: =' num2str(gBest)];
disp(str)
%输出最优解
str=['the max value is : =' num2str(gBestValue)];
disp(str)

figure
plot(tBest);
xlabel('迭代次数') ;
ylabel('适应度值') ;
title('适应度进化曲线') ;
