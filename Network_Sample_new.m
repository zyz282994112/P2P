function [out]=Network_Sample_new(input,lamada)
%%�������������г�����lamadaΪ��������
    tmp=randperm(length(input));
    out=zeros(size(input));
    count=fix(lamada*size(input,1));
    out(tmp(1:count))=input(tmp(1:count));
end