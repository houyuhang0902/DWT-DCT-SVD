function NC = ncc(ImageA,ImageB)
% ื๎บร
ImageA=double(ImageA);
ImageB=double(ImageB.*255);
[M,N]=size(ImageA);
sum=0;
sum1=0;
sum2=0;
for i=1:M
    for j=1:N
        sum=sum+ImageA(i,j)*ImageB(i,j);
        sum1=sum1+ImageA(i,j)*ImageA(i,j);
        sum2=sum2+ImageB(i,j)*ImageB(i,j);
    end
end
NC=sum/(sqrt(sum1)*sqrt(sum2));
end