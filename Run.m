%��Ҫ����matlab��������
load('���������ļ�.mat');

maxuser=1314468;
maxloan=401762;
minquan=0.00001;  %����laplaceȨ�أ�ʹ�ü���ĶԽ�����������
minsample=0.2; %����ڵ��������



%%����Sij
[Slobo Slole] = Compute_Sij(R_loan_borrower,R_loan_lender,maxloan,maxuser,minquan);

compute_code_bad;
compute_code_normall;


%%�����������[�滵Ԥ�� �滵Ԥ��;����Ԥ�� ����Ԥ��]
huaihuai=0;
huaihao=0;
clo=zeros(size(flo_bad,1),1);
for i=1:size(flo_bad,1)
    if (flo_bad(i)>flo_normall(i) || flo_bad(i)==Inf)
        if ylo_all_bad(i)==1
            huaihuai=huaihuai+1;
        else
            huaihao=huaihao+1;
        end
        clo(i)=1;
    end
end
confusion_matrix=[huaihuai sum(ylo_all_bad)-huaihuai;huaihao sum(ylo_all_normall)-huaihao];


%%����׼ȷ�ʣ��ٻ���
precision_bad=huaihuai/(huaihuai+huaihao);
recall_bad=huaihuai/sum(ylo_all_bad);
precision_normall=(sum(ylo_all_normall)-huaihao)/(sum(ylo_all_bad)+sum(ylo_all_normall)-sum(clo));
recall_normall=(sum(ylo_all_normall)-huaihao)/sum(ylo_all_normall);
tmp=sprintf('����׼ȷ�ʣ�%g;�����ٻ��ʣ�%g��',precision_bad,recall_bad);
disp(tmp);
tmp=sprintf('����׼ȷ�ʣ�%g;�����ٻ��ʣ�%g��',precision_normall,recall_normall);
disp(tmp);


%����AUC
[result M N]=AUC_train_only(ylo_all_bad,clo,ylo_all_bad+ylo_all_normall,confusion_matrix);
tmp=sprintf('����AUC��%g��',result);
disp(tmp);