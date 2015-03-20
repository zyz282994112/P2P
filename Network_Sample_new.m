function [out]=Network_Sample_new(input,lamada)
%%对输入的网络进行抽样，lamada为抽样比例
    tmp=randperm(length(input));
    out=zeros(size(input));
    count=fix(lamada*size(input,1));
    out(tmp(1:count))=input(tmp(1:count));
end