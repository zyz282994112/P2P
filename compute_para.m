%%������ֲ���

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
confusion_matrix=[huaihuai-sum(ylo==1) sum(ylo_all_bad)-huaihuai;huaihao sum(ylo_all_normall)-huaihao-sum(ylo==-1)];


%%����׼ȷ�ʣ��ٻ���
% precision_bad=huaihuai/(huaihuai+huaihao);
precision_bad=(huaihuai-sum(ylo==1))/(huaihuai+huaihao-sum(ylo==1));%%ȥ��ԭ�����б�ǵĲ��֣���Ϊ�ⲿ��100%��ȷ��
recall_bad=(huaihuai-sum(ylo==1))/(sum(ylo_all_bad)-sum(ylo==1));%%ȥ��ԭ�����б�ǵĲ��֣���Ϊ�ⲿ��100%��ȷ��
precision_normall=(sum(ylo_all_normall)-huaihao-sum(ylo==-1))/(sum(ylo_all_bad)+sum(ylo_all_normall)-sum(clo)-sum(ylo==-1));
recall_normall=(sum(ylo_all_normall)-huaihao-sum(ylo==-1))/(sum(ylo_all_normall)-sum(ylo==-1));
tmp=sprintf('����׼ȷ�ʣ�%g;�����ٻ��ʣ�%g��',precision_bad,recall_bad);
disp(tmp);
tmp=sprintf('����׼ȷ�ʣ�%g;�����ٻ��ʣ�%g��',precision_normall,recall_normall);
disp(tmp);


%����AUC
ylo_all_bad_tmp=ylo_all_bad;
ylo_all_normall_tmp=ylo_all_normall;
ylo_all_bad_tmp(~ylo==0,:)=[];%%ȥ��ԭ�����б�ǵĲ��֣���Ϊ�ⲿ��100%��ȷ��
ylo_all_normall_tmp(~ylo==0,:)=[];%%ȥ��ԭ�����б�ǵĲ��֣���Ϊ�ⲿ��100%��ȷ��
clo(~ylo==0,:)=[];%%ȥ��ԭ�����б�ǵĲ��֣���Ϊ�ⲿ��100%��ȷ��

[result M N]=AUC_train_only(ylo_all_bad_tmp,clo,ylo_all_bad_tmp+ylo_all_normall_tmp,confusion_matrix);
tmp=sprintf('����AUC��%g��',result);
disp(tmp);