clear
%%1表示正常结束，-1表示坏账，0表示未知

load('P2PRowData.mat');%%不知道怎么写

num=3;

DataLabel=cell(num,1);
DataFeature=cell(num,1);
DataMatrix=cell(num,num);

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

DataMatrix{1,3}=Data_Clean(MatrixTransform(R_loan_borrower,V_lo,V_bo),V_lo,V_bo);
DataMatrix{3,1}=DataMatrix{1,3}';
DataMatrix{1,2}=Data_Clean(MatrixTransform(R_loan_lender,V_lo,V_le),V_lo,V_le);
DataMatrix{2,1}=DataMatrix{1,2}';

DataLabel{1}=ylo_all_normall+(-1)*ylo_all_bad;
DataLabel{2}=zeros(size(yle_all_bad));
DataLabel{3}=zeros(size(ybo_all_bad));

% DataFeature{1,1}=feature;

UnlabelTag=0;
ComputeLabel='-1';
% cell2mat(Unbalanceweight(cell2mat(Unbalanceweight(:,1))==-1,2))

clear ybo_all_bad yle_all_bad yle_all_bad ylo_all_bad ylo_all_normall yle_all_normall ybo_all_normall feature V_lo V_bo V_le maxuser maxloan R_loan_borrower R_loan_lender
clear inputborrower_bad inputborrower_normall inputlender_bad inputlender_normall inputloan_bad inputloan_normall num

save 'P2P.mat'