function [Sij] = ComputeSij(Rij)
%º∆À„Rijæÿ’ÛµƒSij°£
%Sij=Dij^-0.5*Rij*Dji^-0.5
% Dij=diag(sum(Rij')); %#ok<UDIM>
% Dji=diag(sum(Rij));
% Dij(any(Dij'~=0),any(Dij~=0))=Dij(any(Dij'~=0),any(Dij~=0))^-1;
% Dji(any(Dji'~=0),any(Dji~=0))=Dji(any(Dji'~=0),any(Dji~=0))^-1;

Dij=sum(Rij'); %#ok<*UDIM>
Dij(Dij~=0)=Dij(Dij~=0).^-0.5;

Dji=sum(Rij);
Dji(Dji~=0)=Dji(Dji~=0).^-0.5;

Sij=diag(Dij)*Rij*diag(Dji);
end
