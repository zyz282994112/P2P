function [output]=Data_Clean(input,V1,V2)
%%ɾ�������е�ȫ0�к�ȫ���в�����
    if nargin ==1
        input(~any(input'),:)=[];%%ɾ��ȫ����
        input(:,~any(input))=[];%%ɾ��ȫ����
    else if nargin == 2
            input(V1==0,:)=[];%%ɾ��ȫ����
        else
            input(V1==0,:)=[];%%ɾ��ȫ����
            input(:,V2==0)=[];%%ɾ��ȫ����
        end
    end
    output=input;
end



