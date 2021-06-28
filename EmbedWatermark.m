function [Iwm,Uw,Vw]=EmbedWatermark(Image,Water)

%Water=imresize(Water,[64,64]);
Water=double(Water.*255);
[Uw,Sw,Vw]=svd(Water);

Ir=Image(:,:,1);
Ig=Image(:,:,2);
Ib=Image(:,:,3);


%% R通道的嵌入流程
[IrLL1,IrHL1,IrLH1,IrHH1]=dwt2(Ir,'haar');
[IrLL2,IrHL2,IrLH2,IrHH2]=dwt2(IrLL1,'haar');
[IrLL,IrHL,IrLH,IrHH]=dwt2(IrLL2,'haar');
IrLLdct=dct2(IrLL);
[Ur,Sr,Vr]=svd(IrLLdct);

Sm=Sr+0.2*Sw;  %0.2是嵌入强度，不同的图像或者水印可以调
IrLLdctm=Ur*Sm*Vr';
IrLLdctm=idct2(IrLLdctm);
IrLL2m=idwt2(IrLLdctm,IrHL,IrLH,IrHH,'haar');
IrLL1m=idwt2(IrLL2m,IrHL2,IrLH2,IrHH2,'haar');
Irm=idwt2(IrLL1m,IrHL1,IrLH1,IrHH1,'haar');

%% 其他两个通道的

[IgLL1,IgHL1,IgLH1,IgHH1]=dwt2(Ig,'haar');
[IgLL2,IgHL2,IgLH2,IgHH2]=dwt2(IgLL1,'haar');
[IgLL,IgHL,IgLH,IgHH]=dwt2(IgLL2,'haar');
IgLLdct=dct2(IgLL);
[Ug,Sg,Vg]=svd(IgLLdct);

Sm=Sg+0.2*Sw;
IgLLdctm=Ug*Sm*Vg';
IgLLdctm=idct2(IgLLdctm);
IgLL2m=idwt2(IgLLdctm,IgHL,IgLH,IgHH,'haar');
IgLL1m=idwt2(IgLL2m,IgHL2,IgLH2,IgHH2,'haar');
Igm=idwt2(IgLL1m,IgHL1,IgLH1,IgHH1,'haar');



[IbLL1,IbHL1,IbLH1,IbHH1]=dwt2(Ib,'haar');
[IbLL2,IbHL2,IbLH2,IbHH2]=dwt2(IbLL1,'haar');
[IbLL,IbHL,IbLH,IbHH]=dwt2(IbLL2,'haar');
IbLLdct=dct2(IbLL);
[Ub,Sb,Vb]=svd(IbLLdct);

Sm=Sb+0.2*Sw;
IbLLdctm=Ub*Sm*Vb';
IbLLdctm=idct2(IbLLdctm);
IbLL2m=idwt2(IbLLdctm,IbHL,IbLH,IbHH,'haar');
IbLL1m=idwt2(IbLL2m,IbHL2,IbLH2,IbHH2,'haar');
Ibm=idwt2(IbLL1m,IbHL1,IbLH1,IbHH1,'haar');


%% 三个通道合并
Iwm(:,:,1)=Irm;
Iwm(:,:,2)=Igm;
Iwm(:,:,3)=Ibm;

[PSNR]=RGBPSNR(Image, uint8(Iwm))
%imshow(uint8(Iwm))
%%Iwm = noiseAttack(Iwm);
%% 3-DWT-SVD中嵌入函数是Embed  ，提取函数是Extract，攻击实验的函数也在3DWT-SVD中
end