clear
%%1��ʾ����������-1��ʾ���ˣ�0��ʾδ֪

load('P2PRowData.mat');%%��֪����ôд

DataLabel=cell(3,1);
DataFeature=cell(3,1);
DataMatrix=cell(3,3);

maxuser=1314468;
maxloan=401762;

V_lo=VectorTransform(R_loan_borrower(:,1),maxloan)|VectorTransform(R_loan_lender(:,1),maxloan);
ylo_all_bad=VectorTransform(inputloan_bad,maxloan);
ylo_all_bad=Data_Clean(ylo_all_bad,V_lo);
ylo_all_normall=VectorTransform(inputloan_normall,maxloan);
ylo_all_normall=Data_Clean(ylo_all_normall,V_lo);

V_bo=VectorTransform(R_loan_borrower(:,2),maxuser);
ybo_all_bad=VectorTransform(inputborrower_bad,maxuser);
ybo_all_bad=Data_Clean(ybo_all_bad,V_bo);
% ybo_all_normall=VectorTransform(inputborrower_normall,maxuser);
% ybo_all_normall=Data_Clean(ybo_all_normall,V_bo);

V_le=VectorTransform(R_loan_lender(:,2),maxuser);
yle_all_bad=VectorTransform(inputlender_bad,maxuser);
yle_all_bad=Data_Clean(yle_all_bad,V_le);
% yle_all_normall=VectorTransform(inputlender_normall,maxuser);
% yle_all_normall=Data_Clean(yle_all_normall,V_le)*2;

DataMatrix{1,2}=Data_Clean(MatrixTransform(R_loan_borrower,V_lo,V_bo),V_lo,V_bo);
DataMatrix{2,1}=DataMatrix{1,2}';
DataMatrix{1,3}=Data_Clean(MatrixTransform(R_loan_lender,V_lo,V_le),V_lo,V_le);
DataMatrix{3,1}=DataMatrix{1,3}';

DataLabel{1}=ylo_all_normall+(-1)*ylo_all_bad;
DataLabel{2}=zeros(size(ybo_all_bad));
DataLabel{3}=zeros(size(yle_all_bad));
% DataLabel{2}=ybo_all_bad+ybo_all_normall;
% DataLabel{3}=yle_all_bad+yle_all_normall;
% DataFeature{1,1}=feature;

UnlabelTag=0;
% cell2mat(Unbalanceweight(cell2mat(Unbalanceweight(:,1))==-1,2))
Unbalanceweight={-1,20;1,1};

clear ybo_all_bad yle_all_bad yle_all_bad ylo_all_bad ylo_all_normall yle_all_normall ybo_all_normall feature V_lo V_bo V_le maxuser maxloan R_loan_borrower R_loan_lender
clear inputborrower_bad inputborrower_normall inputlender_bad inputlender_normall inputloan_bad inputloan_normall

save 'P2P.mat'