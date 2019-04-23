im1 = imread('image22.png');
figure;
subplot(221);imshow(im1);title('input image');
%imgray = rgb2gray(im1);
R=im1(:,:,1); 
G=im1(:,:,2);
B=im1(:,:,3);
imgray=(0.114 .*R)+(0.587 .*G)+(0.299 .*B);
subplot(222);imshow(imgray);title('rgbtogray image');
imm = medfilt2(imgray);
imh = histeq(imm);
ime = edge(imh, 'sobel');
subplot(223);imshow(ime);title('Edge detection by sobel');
%se=[0 0 0;1 1 1;0 0 0];
se = strel('line',10,90);
imd = imdilate(ime,se);
subplot(224);imshow(imd);title('Morphological Dilation Operation');
% se1=[0 1 0;0 1 0;0 1 0];
se1 = strel('line',30,0);
imd1 = imdilate(imd,se1);
figure;
subplot(221);imshow(imd1);title('Morphological Dilation Operation');
imf=imfill(imd1,'holes');
subplot(222);imshow(imf);title('After filling holes');
imbw = bwareaopen(imf,100);
subplot(223);imshow(imbw);title('After removing objects');
imclr=imclearborder(imbw);
subplot(224);imshow(imclr);title('After clearing border');
se3 = strel('line',12,0);
imer = imerode(imclr,se3);
%imer = imerode(imclr, strel('diamond', 3));
%imer1 = imerode(imer, strel('diamond', 3));
imer1 = imerode(imer,se3);
figure;
subplot(221);imshow(imer1);title('Morphological Erotion Operation');
Z = immultiply(imer1,imgray);
subplot(222);imshow(Z);title('Multiply');

Iprops=regionprops(imer1,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end 
im2 = imcrop(Z, boundingBox);
subplot(222);imshow(im2);title('plate');
imbn = imbinarize(im2);
subplot(223);imshow(im2);title('binary');
se_n = strel('disk',1);

 op1 = imopen(imbn, se_n);
 target1 = imcomplement(op1);
 subplot(224);imshow(target1);title('binary enhanced');

[h, w] = size(op1);
Charprops=regionprops(target1,'BoundingBox','Area','Image');
count1 = numel(Charprops);

noPlate=[]; % Initializing the variable of number plate string.

for i=1:count1
   ow = length(Charprops(i).Image(1,:));
   oh = length(Charprops(i).Image(:,1));
   if ow<(h/2) && oh>(h/3)
       letter=readLetter(Charprops(i).Image); % Reading the letter corresponding the binary image 'N'.
       %figure; imshow(Charprops(i).Image);
       noPlate=[noPlate letter]; % Appending every subsequent character in noPlate variable.
   end
end
countChar = 0;
for i = 1: length(noPlate)
    countChar = countChar+1;
end

%Character Recognition
fileID=fopen('character.txt','wt');
fprintf(fileID,'%s\n',noPlate);
fprintf(fileID,'\nTotal Number of Character = %d',countChar);
fclose(fileID);