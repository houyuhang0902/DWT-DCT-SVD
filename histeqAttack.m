%% histeq Attack
function histeqAttacked = histeqAttack(watermarked_image)
watermarked_image=uint8(watermarked_image);
histeqAttacked=histeq(watermarked_image);
end