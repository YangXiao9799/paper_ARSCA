function [ k1,k2 ] = GetRan2( num,N )
%��1��N���������2��������num������,��ֵ��k1��k2
%   �˴���ʾ��ϸ˵��
k1=randperm(N,1);
while(k1==num)
  k1=randperm(N,1);
end
k2=randperm(N,1);
while((k2==num) || (k2==k1))
  k2=randperm(N,1);
end
end

