function [L,U,P,y,x] = fun_LU(A,b)

% Function：LU Factorization to Solve Nonsingular System
% Editor:Shi Jingwen
% Data:2016/9/23

%一.Preprocess
% 1.清空工作空间
% 2.检查是否为方阵 m=n
% 3.检查矩阵是否可逆

s = size(A);
row = s(1);
colum = s(2);
r = rank(A);
if row == colum & r == row
    fprintf(2,'This is a square and invertible matrix!\n');
    P = [1;2;3;4];
    E = eye(row);
    p = eye(row);
    L = zeros(row,colum)
    %二.寻找绝对值最大的主元，交换位置
    for i = 1:row-1
        pro_colum = A(i:row,i);
        [pivot,max_col] = max(abs(pro_colum));
        A([i,max_col+i-1],:)=A([max_col+i-1,i],:);
        p([i,max_col+i-1],:)=p([max_col+i-1,i],:);
        P([i,max_col+i-1],:)=P([max_col+i-1,i],:);
        L([i,max_col+i-1],:)=L([max_col+i-1,i],:);
        %三.对以下各行进行消元
        for k = i+1:row
            L(k,i) = A(k,i)/A(i,i);
            A(k,:) = A(k,:)-L(k,i)*A(i,:);
        end
    end
    fprintf(2,'After LU Factorization:\n');
    L = L+E
    U = A
    P
    fprintf(2,'Solve Ax=b\n');
    %四.根据LU解方程
    y=L\(p*b)
    x = U\y
else
    fprintf(2,'This is not a square or invertible matrix!\n');
end
end

