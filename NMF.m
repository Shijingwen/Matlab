%V����ԭʼ����W��H�����ֽ�֮��õ��ķǸ�����
%R������Ϊ֮���ά����K������������,E��¼���
function [W,H] = NMF(R,k)
    V = rand(5,5);
    [m,n]=size(V);
    W = abs(rand(n,R));
    H = abs(rand(R,m));
    E=zeros(k);
    t = 1:1:100;
    %��������
    for i = 1:k
        H = H .* (W'*V) ./ ((W'*W)*H);
        W = W .* (V*H') ./ (W*(H*H'));
        WH = W*H-V;
        E(i) = sum(sum(WH .^ 2));
    end
    %������
    V
    W
    H
    WH
    %�������ͼ��
    plot(t,E,'r-');
end