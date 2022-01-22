function W=LCMVFilter(Ltarget,Cmeas,regalpha)
% LCMVFILTER makes LCMV beamformer filters for a set of target sources
% function W=LCMVFilter(Ltarget,Cmeas,regalpha)
%
%  Ltarget:  a set of target topographies, [Nsensors x Ntarget]
%  Cmeas:    measurement covariance matrix, [Nsensors x Nsensors]
%  regalpha: regularization coefficient, lambda = regalpha*mean(diag(Cmeas))
%            (optional, default 0.05);
%
%  W:        spatial filters, [Ntarget x Nsensors]
%
% The function assumes that all sensors are of the same type and noise is
%  white.
% NBE-E4000, v191029 Matti Stenroos
if nargin<3 || isempty(regalpha)
    regalpha=.05;
end
[Nsens,Ntargets]=size(Ltarget);
W=zeros(Ntargets,Nsens);
lambda=regalpha*mean(diag(Cmeas));
Cmreg=Cmeas+lambda*eye(Nsens);
Cminv=inv(Cmreg);
for I=1:Ntargets
    li=Ltarget(:,I);
    den=li'*Cminv*li;
    W(I,:)=(li'*Cminv)./den;
end
