%% Filter Attack
function filterImageAttacked = FilterAttack(watermarked_image,num)
watermarked_image=uint8(watermarked_image);
if num == 1
W = fspecial('gaussian',[5,5],1); 
filterImageAttacked = imfilter(watermarked_image,W,'replicate');
elseif num == 2
Ir=watermarked_image(:,:,1);
Ig=watermarked_image(:,:,2);
Ib=watermarked_image(:,:,3);
Irm = medfilt2(Ir,[5,5]);
Igm = medfilt2(Ig,[5,5]);
Ibm = medfilt2(Ib,[5,5]);
filterImageAttacked(:,:,1)=Irm;
filterImageAttacked(:,:,2)=Igm;
filterImageAttacked(:,:,3)=Ibm;
else 
W = fspecial('average',[5,5]);
filterImageAttacked = imfilter(watermarked_image,W);
end