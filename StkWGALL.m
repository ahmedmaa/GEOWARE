% This function computes the geoid using Wong and Gore modified kernel 
% 
%
%
% Inputs:
%         fm : The latitudes truncated within the computation window
%         lm : The longitudes truncated within the computation window
% dfi & dlam : The resolution of the grid in degrees
%         c  : The truncated computation window
%         R  : The Earth's mean radius
%         ng : The normal gravity anomaly computed by Somigliana's formula
%         L  : The maximum modification degree
%     
% Output: NW: % This function computes the geoid using least-squares modified Stokes kernel 
% 
%
%
% Inputs:
%         fm : The latitudes truncated within the computation window
%         lm : The longitudes truncated within the computation window
% dfi & dlam : The resolution of the grid in degrees
%         c  : The truncated computation window
%         R  : The Earth's mean radius
%         ng : The normal gravity anomaly computed by Somigliana's formula
%         
%     
% Output: N1: High-frequency geoid height
%                        
%                      
%
%                            Ahmed Abdalla
%                     Louisiana State University
%                          September 2017
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
function [NW] = StkWGALL(fm,lm,dfi,dlam,c,R,ng,L)
fi=c(:,2);
lam=c(:,1);
% spherical distance
s1=acos(sind(fm).*sind(fi)+cosd(fm).*cosd(fi).*cosd(lam-lm));
% computing the block area A
A1=2*dlam*pi/180*sind(dfi/2)*cosd(fi);
% Stokes kernel
Stk=(1./(sin(s1./2)))-6.*sin(s1./2)+1-5.*cos(s1)-3.*cos(s1).*log(sin(s1./2)+(sin(s1./2)).^2);
t=cos(s1)';
Pn1=zeros(L+1,length(c));
Pn1(1,1:length(c))=1;
Pn1(2,1:length(c))=t';
n1=[1:L+1]';
[P,wgf] = lgpoly(t,L);
unsum=(wgf(3:length(wgf),1).*P(3:length(wgf),1:length(c)));
HG=sum(unsum(:,1:length(c)));
STHG=Stk-HG';
DF=(c(:,3).*STHG.*A1);
T1=sum(DF);
NW=T1*(R/(4*pi*ng));
end
