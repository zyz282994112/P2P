function [output]=Data_Clean(input,V1,V2)
%%删除矩阵中的全0行和全零列并返回
    if nargin ==1
        input(~any(input'),:)=[];%%删除全零行
        input(:,~any(input))=[];%%删除全零列
    else if nargin == 2
            input(V1==0,:)=[];%%删除全零行
        else
            input(V1==0,:)=[];%%删除全零行
            input(:,V2==0)=[];%%删除全零列
        end
    end
    output=input;
end



