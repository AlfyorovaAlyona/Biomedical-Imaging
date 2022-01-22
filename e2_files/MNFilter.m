function W=MNFilter(L,targetinds,SNR2,normalize_flag)
% MNFILTER builds minimum-norm spatial filters for a set of target sources
% function W=MNFilter(L,targetinds,SNR2)
%
%   L:          lead field matrix, [Nsensors x Nsources]
%   targetinds: source indices, where the filters are targeted, [Ntarget x 1]
%   SNR2:       regularization parameter in terms of power-SNR
%   normalize:  1 (default) for a filter that has unit gain at target location,
%               0 for an unnormalized filter = a row of MN estimator 
%
%   W:          filters, [Ntarget x Nsensors]
%
%   The function assumes that all sensors are of the same type and noise is
%   white.
%
% NBE-E4000, v201001 Matti Stenroos
Nsens=size(L,1);
Ntarget=numel(targetinds);

gram=L*L.';
lambda2=trace(gram)/(Nsens*SNR2);
modelcov=gram+lambda2*eye(Nsens);
Ltarget=L(:,targetinds);
W=Ltarget.'/modelcov;

if nargin<4 || normalize_flag
    %normalize "self gains" to 1
    Wselfgain=zeros(Ntarget,1);
    for I=1:Ntarget
        Wselfgain(I)=W(I,:)*Ltarget(:,I);
    end
    W=diag(1./Wselfgain)*W;
end