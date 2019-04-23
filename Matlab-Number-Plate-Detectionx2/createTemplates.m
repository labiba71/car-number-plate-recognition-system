%CREATE TEMPLATES
%Letter
A=imread('char/A.bmp');
B=imread('char/B.bmp');
C=imread('char/C.bmp');
D=imread('char/D.bmp');
E=imread('char/E.bmp');
F=imread('char/F.bmp');
G=imread('char/G.bmp');
H=imread('char/H.bmp');
I=imread('char/I.bmp');
J=imread('char/J.bmp');
K=imread('char/K.bmp');
L=imread('char/L.bmp');
M=imread('char/M.bmp');
N=imread('char/N.bmp');
O=imread('char/O.bmp');
P=imread('char/P.bmp');
Q=imread('char/Q.bmp');
R=imread('char/R.bmp');
S=imread('char/S.bmp');
T=imread('char/T.bmp');
U=imread('char/U.bmp');
V=imread('char/V.bmp');
W=imread('char/W.bmp');
X=imread('char/X.bmp');
Y=imread('char/Y.bmp');
Z=imread('char/Z.bmp');
Afill=imread('char/fillA.bmp');
Bfill=imread('char/fillB.bmp');
Dfill=imread('char/fillD.bmp');
Ofill=imread('char/fillO.bmp');
Pfill=imread('char/fillP.bmp');
Qfill=imread('char/fillQ.bmp');
Rfill=imread('char/fillR.bmp');
%Number
one=imread('char/1.bmp');  two=imread('char/2.bmp');
three=imread('char/3.bmp');four=imread('char/4.bmp');
five=imread('char/5.bmp'); six=imread('char/6.bmp');
seven=imread('char/7.bmp');eight=imread('char/8.bmp');
nine=imread('char/9.bmp'); zero=imread('char/0.bmp');
zerofill=imread('char/fill0.bmp');
fourfill=imread('char/fill4.bmp');
sixfill=imread('char/fill6.bmp');
sixfill2=imread('char/fill6_2.bmp');
eightfill=imread('char/fill8.bmp');
ninefill=imread('char/fill9.bmp');
ninefill2=imread('char/fill9_2.bmp');

letter=[A Afill B Bfill C D Dfill E F G H I J K L M N O Ofill P Pfill Q Qfill R Rfill S T U V W X Y Z];
number=[one two three four fourfill five six sixfill sixfill2 seven eight eightfill nine ninefill ninefill2 zero zerofill];
character=[letter number];
NewTemplates=mat2cell(character,42,[24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24]);

save ('NewTemplates','NewTemplates')