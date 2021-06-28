function [PSNR]=RGBPSNR(ReferenceRGB, Comparison)
% [m,n,l]=size(ReferenceRGB);
% M = m * n * 255 * 255 * 3;
% N = (double(Comparison) - double(ReferenceRGB)).^2;
% X = sum(N(:));
% PSNR = 10 * log10( M / X);

%  MSE = 1/mn*sum(|Comparison-ReferenceRGB|.^2)
%  PSNR = 10*log10(MAX^2/MSE)
% 求三个通道的MSE（方差）均值，计算PSNR
[m,n,l]=size(ReferenceRGB);
Rer =  ReferenceRGB(:,:,1);
Reg =  ReferenceRGB(:,:,2);
Reb =  ReferenceRGB(:,:,3);
Cor =  Comparison(:,:,1);
Cog =  Comparison(:,:,2);
Cob =  Comparison(:,:,3);
Nr = (double(Cor) - double(Rer)).^2;
Xr = sum(Nr(:));
MSRr = 1/(m*n)*Xr;
Ng = (double(Cog) - double(Reg)).^2;
Xg = sum(Ng(:));
MSRg = 1/(m*n)*Xg;
Nb = (double(Cob) - double(Reb)).^2;
Xb = sum(Nb(:));
MSRb = 1/(m*n)*Xb;
MSR = mean([MSRr,MSRg,MSRb]);
M = 255 * 255;
PSNR = 10 * log10( M / MSR);
end       