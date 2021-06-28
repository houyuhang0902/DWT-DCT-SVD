function [WaterR,WaterG,WaterB]=ExtractWatermark(Iwm,Image,Uw,Vw,Water)

Ir=Image(:,:,1);
Ig=Image(:,:,2);
Ib=Image(:,:,3);

Irm=Iwm(:,:,1);
Igm=Iwm(:,:,2);
Ibm=Iwm(:,:,3);

%% 提取R通道水印
[IrLL1,IrHL1,IrLH1,IrHH1]=dwt2(Ir,'haar');
[IrLL2,IrHL2,IrLH2,IrHH2]=dwt2(IrLL1,'haar');
[IrLL,IrHL,IrLH,IrHH]=dwt2(IrLL2,'haar');
IrLLdct=dct2(IrLL);
[Ur,Sr,Vr]=svd(IrLLdct);

[IrLL1m,IrHL1m,IrLH1m,IrHH1m]=dwt2(Irm,'haar');
[IrLL2m,IrHL2m,IrLH2m,IrHH2m]=dwt2(IrLL1m,'haar');
[IrLLm,IrHLm,IrLHm,IrHHm]=dwt2(IrLL2m,'haar');
IrLLdctm=dct2(IrLLm);
[Urm,Srm,Vrm]=svd(IrLLdctm);

WaterR=Uw*(Srm-Sr)/0.2*Vw';
% imshow(uint8(WaterR))
NCR=ncc(uint8(WaterR),Water)


%% 提取G通道水印
[IgLL1,IgHL1,IgLH1,IgHH1]=dwt2(Ig,'haar');
[IgLL2,IgHL2,IgLH2,IgHH2]=dwt2(IgLL1,'haar');
[IgLL,IgHL,IgLH,IgHH]=dwt2(IgLL2,'haar');
IgLLdct=dct2(IgLL);
[Ug,Sg,Vg]=svd(IgLLdct);

[IgLL1m,IgHL1m,IgLH1m,IgHH1m]=dwt2(Igm,'haar');
[IgLL2m,IgHL2m,IgLH2m,IgHH2m]=dwt2(IgLL1m,'haar');
[IgLLm,IgHLm,IgLHm,IgHHm]=dwt2(IgLL2m,'haar');
IgLLdctm=dct2(IgLLm);
[Ugm,Sgm,Vgm]=svd(IgLLdctm);

WaterG=Uw*(Sgm-Sg)/0.2*Vw';
% imshow(uint8(WaterG))
NCG=ncc(uint8(WaterG),Water)

%% 提取B通道水印
[IbLL1,IbHL1,IbLH1,IbHH1]=dwt2(Ib,'haar');
[IbLL2,IbHL2,IbLH2,IbHH2]=dwt2(IbLL1,'haar');
[IbLL,IbHL,IbLH,IbHH]=dwt2(IbLL2,'haar');
IbLLdct=dct2(IbLL);
[Ub,Sb,Vb]=svd(IbLLdct);

[IbLL1m,IbHL1m,IbLH1m,IbHH1m]=dwt2(Ibm,'haar');
[IbLL2m,IbHL2m,IbLH2m,IbHH2m]=dwt2(IbLL1m,'haar');
[IbLLm,IbHLm,IbLHm,IbHHm]=dwt2(IbLL2m,'haar');
IbLLdctm=dct2(IbLLm);
[Ubm,Sbm,Vbm]=svd(IbLLdctm);

WaterB=Uw*(Sbm-Sb)/0.2*Vw';
NCB=ncc(uint8(WaterB),Water)
end