close all
clear
clc
 
%% Read Images
% the size of images must be equal
[file, pathname] = uigetfile('*.gif','Load Image 1 ');cd(pathname);
a=imread(file);
[file, pathname] = uigetfile('*.gif','Load Image 2 ');cd(pathname);
b=imread(file);
[file, pathname] = uigetfile('*.gif','Load Image 3 ');cd(pathname);
m=imread(file);
 
imshow(a)
title('First Image')
figure,imshow(b)
title('Second Image')
figure,imshow(m)
title('Orginal Image')
 
%%   Wavelet Transform 
 
[a1,b1,c1,d1]=dwt2(a,'haar');
[a2,b2,c2,d2]=dwt2(b,'haar');
 
%% ensuring the size of matrix co-efficients
[k1,k2]=size(a1);
 
%% Fusion Rule Combination - 1
 
% Average Rule
for i=1:k1
    for j=1:k2
        a3(i,j)=(a1(i,j)+a2(i,j))/2;
    end
end
 
% Max Rule
for i=1:k1
    for j=1:k2
        b3(i,j)=max(b1(i,j),b2(i,j));
        c3(i,j)=max(c1(i,j),c2(i,j));
        d3(i,j)=max(d1(i,j),d2(i,j));
    end
end
 
% Inverse Wavelet Transformation 
c=idwt2(a3,b3,c3,d3,'haar');
figure,imshow(c,[])
title('Fused Image - 1')
 
 
%% Fusion Rule Combination - 2
 
% Max Rule
for i=1:k1
    for j=1:k2
        a4(i,j)=max(a1(i,j),a2(i,j));
   end
end
 
% Average Rule
for i=1:k1
    for j=1:k2
        b4(i,j)=(b1(i,j)+b2(i,j))/2;
        c4(i,j)=(c1(i,j)+c2(i,j))/2;
        d4(i,j)=(d1(i,j)+d2(i,j))/2;
    end
end
 
% Inverse Wavelet Transformation
d=idwt2(a4,b4,c4,d4,'haar');
figure,imshow(d,[])
title('Fused Image - 2')
 
 
%% Fusion Rule Combination - 3
 
% Average Rule
for i=1:k1
    for j=1:k2
        a5(i,j)=(a1(i,j)+a2(i,j))/2;
        b5(i,j)=(b1(i,j)+b2(i,j))/2;
        c5(i,j)=(c1(i,j)+c2(i,j))/2;
        d5(i,j)=(d1(i,j)+d2(i,j))/2;
    end
end
 
% Inverse Wavelet Transformation
e=idwt2(a5,b5,c5,d5,'haar');
figure,imshow(e,[])
title('Fused Image - 3')
 
%% Fusion Rule Combination - 4
 
% Max Rule
for i=1:k1
    for j=1:k2
        a6(i,j)=max(a1(i,j),a2(i,j));
        b6(i,j)=max(b1(i,j),b2(i,j));
        c6(i,j)=max(c1(i,j),c2(i,j));
        d6(i,j)=max(d1(i,j),d2(i,j));
   end
end
 
% Inverse Wavelet Transformation
f=idwt2(a6,b6,c6,d6,'haar');
figure,imshow(f,[])
title('Fused Image - 4')

CR1 = corr2(c,m);
CR2 = corr2(d,m);
CR3 = corr2(e,m);
CR4 = corr2(f,m);

fprintf('Correlation Coefficient between Image produced from fusion combination 1 & Orginal =%f \n\n',CR1);
fprintf('Correlation Coefficient between Image produced from fusion combination 2 & Orginal =%f \n\n',CR2);
fprintf('Correlation Coefficient between Image produced from fusion combination 3 & Orginal =%f \n\n',CR3);
fprintf('Correlation Coefficient between Image produced from fusion combination 4 & Orginal =%f \n\n',CR4);

S1=ssim(double(c),double(m));
S2=ssim(double(d),double(m));
S3=ssim(double(e),double(m));
S4=ssim(double(f),double(m));

fprintf('SSIM between Image produced from fusion combination 1 & Orginal =%f \n\n',S1);
fprintf('SSIM between Image produced from fusion combination 2 & Orginal =%f \n\n',S2);
fprintf('SSIM between Image produced from fusion combination 3 & Orginal =%f \n\n',S3);
fprintf('SSIM between Image produced from fusion combination 4 & Orginal =%f \n\n',S4);

P1 = piqe(c);
P2 = piqe(d);
P3 = piqe(e);
P4 = piqe(f);

fprintf('PIQE Score of image formed by fusion combination 1 =%f \n\n',P1);
fprintf('PIQE Score of image formed by fusion combination 2 =%f \n\n',P2);
fprintf('PIQE Score of image formed by fusion combination 3 =%f \n\n',P3);
fprintf('PIQE Score of image formed by fusion combination 4 =%f \n\n',P4);

N1 = brisque(c);
N2 = brisque(d);
N3 = brisque(e);
N4 = brisque(f);

fprintf('BRISQUE Score of image formed by fusion combination 1 =%f \n\n',N1);
fprintf('BRISQUE Score of image formed by fusion combination 2 =%f \n\n',N2);
fprintf('BRISQUE Score of image formed by fusion combination 3 =%f \n\n',N3);
fprintf('BRISQUE Score of image formed by fusion combination 4 =%f \n\n',N4);