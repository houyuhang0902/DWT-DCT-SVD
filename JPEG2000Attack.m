function JPEG2000Image=JPEG2000Attack(WatermarkedImage,num)
imwrite(uint8(WatermarkedImage),'JPEG2000Attack.j2k','CompressionRatio',num);
JPEG2000Image=imread('JPEG2000Attack.j2k');
end