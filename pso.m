function  pso(N,D,T,C1,C2,W,Xmin,Xmax,Ymin,Ymax,Vmin,Vmax)
%%  �������������˼
%       N :��Ⱥ��ģ
%       D :����ά��
%       T :��������
%       C1:ѧϰ����1
%       C2 :ѧϰ����2
%       W :����Ȩ��
%       Xmin  ��X�������Сֵ
%       Xmax  ��X��������ֵ
%       Ymin  ��Y�������Сֵ
%       Ymax  ��Y��������ֵ
%       Vmin������С�����ٶ�
%       Vmax  ���������ٶ�

%%  ��ʼ������Ⱥ��λ�ú��ٶ�
%popx = rand(N,D)*(Xmax-Xmin)+Xmin ; % ��ʼ������Ⱥ��λ��(����λ����һ��Dά����)
X = rand(N,1)*(Xmax-Xmin)+Xmin;
Y = rand(N,1)*(Ymax-Ymin)+Ymin;
popx = [X Y];
popv = rand(N,D)*(Vmax-Vmin)+Vmin ; % ��ʼ������Ⱥ���ٶ�(�����ٶ���һ��Dά������) 

%%  ���弫ֵ��Ⱥ�弫ֵ
% ��ʼ��ÿ����ʷ��������
pBest = popx ; 
pBestValue = func_fitness(pBest) ; 
%��ʼ��ȫ����ʷ��������
[gBestValue,index] = max(func_fitness(popx)) ;
gBest = popx(index,:) ;

%%  ����Ѱ��
for t=1:T
    for i=1:N
        % ���¸����λ�ú��ٶ�
        popv(i,:) = W*popv(i,:)+C1*rand*(pBest(i,:)-popx(i,:))+C2*rand*(gBest-popx(i,:)) ;
        popx(i,:) = popx(i,:)+popv(i,:) ;
        % �߽紦������������Χ��ȡ�÷�Χ��ֵ
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
        
        % ����������ʷ����
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
    % ÿ�����Ž��Ӧ��Ŀ�꺯��ֵ
    %tBest(t) = func_objValue(gBest); %#ok<*SAGROW>
    %tBest(t) = func_fitness(gBest);
end

%% ������
%������Ž��Ӧ������λ��
str=['the postition of max_value is: =' num2str(gBest)];
disp(str)
%������Ž�
str=['the max value is : =' num2str(gBestValue)];
disp(str)

figure
plot(tBest);
xlabel('��������') ;
ylabel('��Ӧ��ֵ') ;
title('��Ӧ�Ƚ�������') ;
