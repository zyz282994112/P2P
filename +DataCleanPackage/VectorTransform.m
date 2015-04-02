function V=VectorTransform(V_row,count)
%%将原始向量转化为0-1向量
    V=zeros(count,1);
    tmp=sparse(V_row(:,1),1,1);
    V(1:size(tmp,1),1)=tmp;
end