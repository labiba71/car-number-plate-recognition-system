function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 16-Apr-2019 00:59:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[imname,impath]=uigetfile({'*.jpg;*.png'});
im1=imread([impath,'/',imname]);
axes(handles.axes1);
imshow(im1);title('Original image');
%imgray = rgb2gray(im1);
R=im1(:,:,1); 
G=im1(:,:,2);
B=im1(:,:,3);
imgray=(0.114 .*R)+(0.587 .*G)+(0.299 .*B);
axes(handles.axes3);
imshow(imgray);title('rgbtogray image');
imm = medfilt2(imgray);
axes(handles.axes4);
imshow(imm);title('median filtered image');
imh = histeq(imm);
axes(handles.axes6);
imshow(imh);title('histogram equalization');
ime = edge(imh, 'sobel');
axes(handles.axes7);
imshow(ime);title('Edge detection by sobel');
se = strel('line',10,90);
imd = imdilate(ime,se);
axes(handles.axes8);
imshow(imd);title('Dilation Operation(horizontal)');
se1 = strel('line',30,0);
imd1 = imdilate(imd,se1);
axes(handles.axes9);
imshow(imd);title('Dilation Operation(vertical)');
imf=imfill(imd1,'holes');
axes(handles.axes10);
imshow(imf);title('After filling holes');
imbw = bwareaopen(imf,100);
imclr=imclearborder(imbw);
axes(handles.axes11);
imshow(imclr);title('After clearing border');
se3 = strel('line',12,0);
imer = imerode(imclr,se3);
imer1 = imerode(imer,se3);
axes(handles.axes12);
imshow(imer1);title('Morphological Erotion Operation');
Z = immultiply(imer1,imgray);
axes(handles.axes13);
imshow(Z);title('Number Plate Area Extraction');
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
imbn = imbinarize(im2);
se_n = strel('disk',1);
op1 = imopen(imbn, se_n);
target1 = imcomplement(op1);
[h, w] = size(op1);
Charprops=regionprops(target1,'BoundingBox','Area','Image');
count1 = numel(Charprops);

noPlate=[]; % Initializing the variable of number plate string.

for i=1:count1
   ow = length(Charprops(i).Image(1,:));
   oh = length(Charprops(i).Image(:,1));
   if ow<(h/2) && oh>(h/3)
       letter=readLetter(Charprops(i).Image); % Reading the letter corresponding the binary image 'N'.
    
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
fclose(fileID);
fid = fopen('character.txt','r');
tline = fscanf(fid,'%s');
fclose(fid);
set(handles.text3,'String',tline);
