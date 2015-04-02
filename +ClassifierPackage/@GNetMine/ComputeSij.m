function [Sij] = ComputeSij(~,Rij)
%º∆À„Rijæÿ’ÛµƒSij°£
%Sij=Dij^-0.5*Rij*Dji^-0.5
Dij=diag(sum(Rij')); %#ok<UDIM>
Dji=diag(sum(Rij));

Dij(any(Dij'~=0),any(Dij~=0))=Dij(any(Dij'~=0),any(Dij~=0))^-1;
Dji(any(Dji'~=0),any(Dji~=0))=Dji(any(Dji'~=0),any(Dji~=0))^-1;

Sij=(Dij.^0.5)*Rij*(Dji.^0.5);
end
