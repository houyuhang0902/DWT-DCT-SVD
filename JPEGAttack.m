function JPEGImageAttack=JPEGAttack( wateredImageName,num)
imwrite(uint8(wateredImageName),'JPEGAttack.jpg','jpg','quality',num);
JPEGImageAttack=imread('JPEGAttack.jpg');
end
