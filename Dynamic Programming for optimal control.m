% Function��Dynamic programming for optimal control
% Editor:Shi Jingwen
% Data:2016/9/28
clc;
clear;

%����ͷ���ʱ�䳤�ȡ���������������
B=[1.0,10.0,100.0,1000.0];
T=2.;  
N=1000;%N=100��N=10
dt=T/N;

color=['b','c','y','r'];
set(gcf,'position',[100,200,1200,400],'name',['N=',num2str(N)])


for i = 1:4
b = B(i);
%΢�ַ��̽�k(t)��״̬����x(t)������u(t)����
P=zeros(N+1,3);
X=zeros(N+1,2);
U=zeros(N,1);
%��ʼλ��
X(1,:)=[-2;1];
%���΢�ַ���
[t,p]=ode45( @krhs, T:-dt:0, [b 0. b] );
P(:,:)=p(N+1:-1:1,:)
J=0.;
%��������任����
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
title('λ�����Ž�X1(t)');

subplot(132)
plot(t, X(:,2),color(i));hold on;
leg = legend('b=1','b=10','b=100','b=1000',0);
set(leg,'Fontsize',6);
title('�ٶ����Ž�X2(t)');

subplot(133)
t = 0:dt:T-dt;
plot(t, U,color(i));hold on;
leg = legend('b=1','b=10','b=100','b=1000',0);
set(leg,'Fontsize',6);
title('�������Ž�U(t)');

end

