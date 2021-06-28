function TranslationImageAttack=TranslationAttack(WatermarkedImage)
se=translate(strel(1),[10,10]);
TranslationImageAttack=imdilate(WatermarkedImage,se,'notpacked');
TranslationImageAttack=uint8(TranslationImageAttack);
end