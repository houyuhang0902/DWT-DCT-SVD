function RatateImageAttack=RotationAttack(WatermarkedImage)
RatateImageAttack = imrotate(WatermarkedImage, 20, 'crop');
RatateImageAttack=uint8(RatateImageAttack);
end