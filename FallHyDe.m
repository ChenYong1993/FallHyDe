function [image_FallHyDe] = FallHyDe(img_ori, r, k_subspace)
[Lines, Columns, B] = size(img_ori);
N = Lines*Columns;
%% Noise Transformation
Y = reshape(img_ori, N, B)';
[~, Rw] = estNoise(Y, 'additive');
Rw_ori = Rw;
Y = sqrt(inv(Rw_ori))*Y;
img_ori = reshape(Y', Lines, Columns, B);
%% Extraction of HSNRBs
level = sqrt(diag(Rw));
[~, P] = sort(level);
GB = P(1:floor(B*r));
%% subspace estimation using SVD
Y = reshape(img_ori, N, B)';
[E,~,~]= svd(Y,'econ');
E = E(:,1:k_subspace);
U = E(GB,:);
%%  Fast Estimation of SRCs
R = pinv(U'*U)*U'*reshape(img_ori(:,:,GB),N,length(GB))';
%% reconstruct data 
Y_reconst = E*R;
%% Inverse Noise Transformation
Y_reconst = sqrt(Rw_ori)*Y_reconst;
image_FallHyDe = reshape(Y_reconst',Lines,Columns,B);
end