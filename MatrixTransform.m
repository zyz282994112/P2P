function R=MatrixTransform(R_row,V1,V2)
%%一个矩阵表示两类节点间的链接（也可能是一类节点），输入这两类节点的0-1向量，若向量对应值为0，则说明不包含该id对应的节点
    if nargin==1
        R=sparse(R_row(:,1),R_row(:,2),1);  
    else
        R_row=sparse(R_row(:,1),R_row(:,2),1);
        R=sparse(zeros(size(V1,1),1))*sparse(zeros(size(V2,1),1))';
        R(1:size(R_row,1),1:size(R_row,2))=R_row;
    end
end