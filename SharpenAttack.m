function SharpenAttackImage=SharpenAttack(WatermarkedImage)
WatermarkedImage=double(WatermarkedImage);
WaterR = WatermarkedImage(:,:,1);
WaterG = WatermarkedImage(:,:,2);
WaterB = WatermarkedImage(:,:,3);
%Laplacian=[-1 -1 -1 ; -1 8 -1 ; -1 -1 -1];
Laplacian=0.8*[0 -1 0;-1 4 -1;0 -1 0];
% sharp= conv2(WatermarkedImage,Laplacian,'same');
sharpR= conv2(WaterR,Laplacian,'same');
sharpG= conv2(WaterG,Laplacian,'same');
sharpB= conv2(WaterB,Laplacian,'same');
WatermarkedImage(:,:,1) = WatermarkedImage(:,:,1)+sharpR;
WatermarkedImage(:,:,2) = WatermarkedImage(:,:,2)+sharpG;
WatermarkedImage(:,:,3) = WatermarkedImage(:,:,3)+sharpB;
% SharpenAttackImage=WatermarkedImage+sharp;
SharpenAttackImage=WatermarkedImage;
end
