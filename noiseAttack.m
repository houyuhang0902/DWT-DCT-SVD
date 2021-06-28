%% Noise Attack
function noiseImageAttacked = noiseAttack(watermarked_image,num)
watermarked_image=uint8(watermarked_image);
if num == 1
noiseImageAttacked = imnoise(watermarked_image, 'salt & pepper',0.02);
elseif num == 2
noiseImageAttacked = imnoise(watermarked_image, 'gaussian');
else 
noiseImageAttacked=imnoise(watermarked_image,'speckle',0.01);
%noiseImageAttacked=histeq(watermarked_image);
end