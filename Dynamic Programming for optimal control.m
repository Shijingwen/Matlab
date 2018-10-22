% Function：Dynamic programming for optimal control
% Editor:Shi Jingwen
% Data:2016/9/28
clc;
clear;

%定义惩罚、时间长度、迭代步数、步长
B=[1.0,10.0,100.0,1000.0];
T=2.;  
N=1000;%N=100、N=10
dt=T/N;

color=['b','c','y','r'];
set(gcf,'position',[100,200,1200,400],'name',['N=',num2str(N)])


for i = 1:4
b = B(i);
%微分方程解k(t)、状态方程x(t)、控制u(t)数组
P=zeros(N+1,3);
X=zeros(N+1,2);
U=zeros(N,1);
%初始位置
X(1,:)=[-2;1];
%求解微分方程
[t,p]=ode45( @krhs, T:-dt:0, [b 0. b] );
P(:,:)=p(N+1:-1:1,:)
J=0.;
%迭代计算变换曲线
for k=1:N
    U(k)=-P(k,2)*X(k,1)-P(k,3)*X(k,2); 
    X(k+1,2)=X(k,2)+dt*U(k);
    X(k+1,1)=X(k,1)+dt*X(k,2);
    r = dt * 0.5 * U(k)^2;
    J = J+r;
end

subplot(131)
t = 0:dt:T;
plot(t, X(:,1),color(i));hold on;
leg = legend('b=1','b=10','b=100','b=1000',0);
set(leg,'Fontsize',6);
title('位置最优解X1(t)');

subplot(132)
plot(t, X(:,2),color(i));hold on;
leg = legend('b=1','b=10','b=100','b=1000',0);
set(leg,'Fontsize',6);
title('速度最优解X2(t)');

subplot(133)
t = 0:dt:T-dt;
plot(t, U,color(i));hold on;
leg = legend('b=1','b=10','b=100','b=1000',0);
set(leg,'Fontsize',6);
title('控制最优解U(t)');

end

