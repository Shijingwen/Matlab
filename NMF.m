%V——原始矩阵，W、H——分解之后得到的非负矩阵
%R——降为之后的维数，K——迭代次数,E记录误差
function [W,H] = NMF(R,k)
    V = rand(5,5);
    [m,n]=size(V);
    W = abs(rand(n,R));
    H = abs(rand(R,m));
    E=zeros(k);
    t = 1:1:100;
    %迭代更新
    for i = 1:k
        H = H .* (W'*V) ./ ((W'*W)*H);
        W = W .* (V*H') ./ (W*(H*H'));
        WH = W*H-V;
        E(i) = sum(sum(WH .^ 2));
    end
    %输出结果
    V
    W
    H
    WH
    %绘制误差图像
    plot(t,E,'r-');
end