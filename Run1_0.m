%��Ҫ����matlab��������
load('���������ļ�.mat');
DataCleanScript;

Slobo=ComputeSij(Rlobo);
Slole=ComputeSij(Rlole);



auc_result=0;
precision_n=0;
precision_b=0;
recall_b=0;
recall_n=0;
for i=1:10
    
    ybo=Network_Sample(DataLabel{3},minsample);
    yle=Network_Sample(DataLabel{2},minsample);           
    ylo=Network_Sample(DataLabel{1},minsample);
    disp('��ʼ�������ˣ�');
    [flo_bad fle_bad fbo_bad]=Iteration_f(Slobo,Slole,ylo,yle,ybo);
    disp('��ʼ���������������');
    [flo_normall fle_normall fbo_normall]=Iteration_f(Slobo,Slole,-ylo,-yle,-ybo);
    compute_para;
    auc_result=auc_result+result;
    precision_n=precision_n+precision_normall;
    precision_b=precision_b+precision_bad;
    recall_b=recall_b+recall_bad;
    recall_n=recall_n+recall_normall;
end

disp('ʮ�۽�������');
tmp=sprintf('����׼ȷ�ʣ�%g;�����ٻ��ʣ�%g��',precision_b/10,recall_b/10);
disp(tmp);
tmp=sprintf('����׼ȷ�ʣ�%g;�����ٻ��ʣ�%g��',precision_n/10,recall_n/10);
disp(tmp);
tmp=sprintf('����AUC��%g��',auc_result/10);
disp(tmp);

