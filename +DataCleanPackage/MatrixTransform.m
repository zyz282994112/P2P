function R=MatrixTransform(R_row,V1,V2)
%%һ�������ʾ����ڵ������ӣ�Ҳ������һ��ڵ㣩������������ڵ��0-1��������������ӦֵΪ0����˵����������id��Ӧ�Ľڵ�
    if nargin==1
        R=sparse(R_row(:,1),R_row(:,2),1);  
    else
        R_row=sparse(R_row(:,1),R_row(:,2),1);
        R=sparse(zeros(size(V1,1),1))*sparse(zeros(size(V2,1),1))';
        R(1:size(R_row,1),1:size(R_row,2))=R_row;
    end
end