function V=VectorTransform(V_row,count)
%%��ԭʼ����ת��Ϊ0-1����
    V=zeros(count,1);
    tmp=sparse(unique(V_row(:,1)),1,1);
    V(1:size(tmp,1),1)=tmp;
end