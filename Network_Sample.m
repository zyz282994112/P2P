function [out]=Network_Sample(input,lamada)
%%�������������г�����lamadaΪ��������
% alphabet=[1 0];
% prob=[lamada 1-lamada];
% tmp=randsrc(size(input,1),size(input,2),[alphabet;prob]);
% out=tmp.*input;
tmp=randperm(length(input));
count=fix(length(input)*lamada);
out=input;
out(tmp((count+1):end))=0;
end