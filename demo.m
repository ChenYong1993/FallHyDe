%% Pavia
rng(1)
clc
clear
load Pavia_80.mat
[M, N, p] = size(OriData3);
B = randperm(p);
parameter = [0.1 4];  
noiselevel = 100;
ratio = parameter(1, 1);
G_band = B(1:floor(p*ratio)); % HSNRB
noise_band = setdiff(B,G_band); % Noise band
sigma =  noiselevel/255*ones(1,length(noise_band));
oriData3_noise = zeros(M, N, p);
for i =1:length(noise_band)
    oriData3_noise(:,:,noise_band(i))=OriData3(:,:,noise_band(i))  + sigma(i)*randn(M,N);
end
oriData3_noise(:,:,G_band) = OriData3(:,:,G_band);

t1 = clock;
[our_result] = FallHyDe(oriData3_noise, parameter(1, 1), parameter(1, 2));
t2=clock;
time = etime(t2,t1);
[psnr, ssim] = MSIQA(our_result*255, OriData3*255);
disp(['PSNR = ' num2str(psnr,'%5.2f'), ', SSIM = ' num2str(ssim,'%5.3f'),...
    ', Time = ' num2str(time,'%5.1f')]);
%% WDC
rng(1);
clear
load WDC_all.mat
OriData3 = wdc;
clear wdc
[M, N, p] = size(OriData3);
B = randperm(p);
parameter = [0.1 8];
noiselevel = 100;
ratio = parameter(1, 1);
G_band = B(1:floor(p*ratio)); % HSNRB
noise_band = setdiff(B,G_band); % Noise band
sigma =  noiselevel/255*ones(1,length(noise_band));
oriData3_noise = zeros(M, N, p);
for i =1:length(noise_band)
    oriData3_noise(:,:,noise_band(i))=OriData3(:,:,noise_band(i))  + sigma(i)*randn(M,N);
end
oriData3_noise(:,:,G_band) = OriData3(:,:,G_band);
%
t1 = clock;
[our_result] = FallHyDe(oriData3_noise, parameter(1, 1), parameter(1, 2));
t2 = clock;
time = etime(t2,t1);
[psnr, ssim] = MSIQA(our_result*255, OriData3*255);
disp(['PSNR = ' num2str(psnr,'%5.2f'), ', SSIM = ' num2str(ssim,'%5.3f'),...
    ', Time = ' num2str(time,'%5.1f')]);
