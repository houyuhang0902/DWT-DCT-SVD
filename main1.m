%«∂»Î
clc,clear,close all
Image=imread('lena.png');
Water=imread('water.png');
[Iwm,Uw,Vw]=EmbedWatermark(Image,Water);
%Iwm = JPEG2000Attack(Iwm,90);
%Iwm = JPEGAttack(Iwm,90);
Iwm = noiseAttack(Iwm,3);
%Iwm = FilterAttack(Iwm,3);
%Iwm = SharpenAttack(Iwm);
%Iwm = histeqAttack(Iwm);
%Iwm = RotationAttack(Iwm);
 figure(1)
 imshow(uint8(Iwm))
[WaterR,WaterG,WaterB]=ExtractWatermark(Iwm,Image,Uw,Vw,Water);
figure(2)
NCR=ncc(uint8(WaterR),Water);
NCG=ncc(uint8(WaterG),Water);
NCB=ncc(uint8(WaterB),Water);
a=[NCR,NCG,NCB];
[m,p]=max(a)
if p==1
    imshow(uint8(WaterR))
elseif p==2
    imshow(uint8(WaterG))
else
    imshow(uint8(WaterB))
end