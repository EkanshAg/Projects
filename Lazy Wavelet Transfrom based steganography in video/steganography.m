
function varargout = steganography(varargin)
% STEGANOGRAPHY MATLAB code for steganography.fig
%      STEGANOGRAPHY, by itself, creates a new STEGANOGRAPHY or raises the existing
%      singleton*.
%
%      H = STEGANOGRAPHY returns the handle to a new STEGANOGRAPHY or the handle to
%      the existing singleton*.
%
%      STEGANOGRAPHY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEGANOGRAPHY.M with the given input arguments.
%
%      STEGANOGRAPHY('Property','Value',...) creates a new STEGANOGRAPHY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before steganography_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to steganography_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help steganography

% Last Modified by GUIDE v2.5 03-Apr-2014 20:42:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @steganography_OpeningFcn, ...
                   'gui_OutputFcn',  @steganography_OutputFcn, ...
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


% --- Executes just before steganography is made visible.
function steganography_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to steganography (see VARARGIN)

% Choose default command line output for steganography
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes steganography wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = steganography_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

% % %Decryption
global select;
% taking input for text file to decypt the text file
if select==1
prompt = {'Enter the decyption key',' '};
dlg_title = 'Input';
num_lines = 1;
def = {'103', '143'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
% d = (answer{1});

d = str2num(answer{1});
Pk = str2num(answer{2});

% taking input from text file
[filename pathname]=uigetfile({'.txt'},'Browse the encrypted text file');

% msgbox('Decryption process has been started');
fulpathname=strcat(pathname,filename);
file=fulpathname;
 fileID = fopen(file);
  cipher = fscanf(fileID,'%c');
  
% M = input('\nEnter the message: ','s');
x=length(cipher);


for j= 1:x
   message(j)= crypt(double(cipher(j)),Pk,d);
end


% disp('Decrypted ASCII of Message:');
% disp(message);
% disp(['Decrypted Message is: ' message]);

% Saving the decypted message file
[file,path] = uiputfile('original_message.txt','Save decrypted file');
fulpathname=strcat(path,file);

 file=fulpathname;
 fileID = fopen(file,'w');
 fwrite(fileID,[message]);
   msgbox('Decryption Completed,Original message is retrieved, File is successfully saved ');
  
end


% taking input for image file as to decrypt the image
if select ==2
    prompt = {'Enter the decryption key'};
dlg_title = 'Input';
num_lines = 1;
def = {'ekansh'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
d = (answer{1});

% to select the image to decrypt
[filename pathname]=uigetfile({'.'},'Browse the encypted image to decrypt'); 
fulpathname=strcat(pathname,filename);
file=fulpathname;
% global M;
M = imread(file);
% outputFullFileName='C:\Users\Ekansh\Desktop\gray.png';
% imwrite(M, outputFullFileName, 'png');
%  msgbox('Decryption process has been started, it would take some time');
% M = input('\nEnter the message: ','s');
M1=M(:,:,1);
M2=M(:,:,2);
M3=M(:,:,3);

cipher_text='';
[m n]=size(M1);
key=d;
l=length(key);
l1=1;
% k=1;
for i=1:m
for j= 1:n
%   for j1=1:n1

%    cipher(k)= crypt(double(M1(i,j)),Pk,e);
  
M1(i,j)= bitxor(double(key(l1)),M1(i,j));
l1=l1+1;
if(l1>l)
    l1=1;
end
%   k=k+1;
% end
end
end


% cipher_text=[cipher_text,cipher];
[m n]=size(M2);
l1=1;

for i=1:m
for j= 1:n
%   for j1=1:n1

%    cipher(k)= crypt(double(M1(i,j)),Pk,e);
  
M2(i,j)= bitxor(double(key(l1)),M2(i,j));
l1=l1+1;
if(l1>l)
    l1=1;
end
%   k=k+1;
% end
end
end
% k=k-1;
% cipher_text=[cipher_text,cipher];
[m n]=size(M3);
l1=1;
for i=1:m
for j= 1:n
%   for j1=1:n1

%    cipher(k)= crypt(double(M1(i,j)),Pk,e);
%   k=k-1;
M3(i,j)= bitxor(double(key(l1)),M3(i,j));
l1=l1+1;
if(l1>l)
    l1=1;
end
%   k=k+1;
% end
end
end
M=cat(3,M1,M2,M3);


[file,path] = uiputfile('original_image.png','Save original_image');
outputFullFileName=strcat(path,file);

% outputFullFileName='C:\Users\Ekansh\Desktop\original_image.png';
imwrite(M, outputFullFileName, 'png');
msgbox('Message has been decrypted and saved.');

end
        
  



% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)

clear all; 
global fulpathname;
[filename pathname]=uigetfile({'.avi'},'Browse the video file'); 
fulpathname=strcat(pathname,filename);
file=fulpathname;
global mov;
mov= mmreader(file);
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function pushbutton5_Callback(hObject, eventdata, handles1)
% to browse the video file , in which data will be hide
clear all; 

[filename pathname]=uigetfile({'.avi'},'Browse the video file'); 
  global fulpathname1;
fulpathname1=strcat(pathname,filename);
file=fulpathname1;

%  fileID = fopen(file);
% filename = 'C:\Users\Ekansh\Desktop\ekansh\project\final ppt\sample.avi';
global mov;
mov= mmreader(file);
inputVideo_FrameRate=mov.FrameRate;  

% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% clc;
% disp('Implementation of RSA Algorithm');
clear all; 
% close all;

prompt = {'Enter 1st prime number:','Enter 2nd prime number:'};
dlg_title = 'Input';
num_lines = 1;
def = {'0','0'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
p = str2num(answer{1});
q = str2num(answer{2});
[Pk,Phi,d,e] = intialize(p,q);

display(e);
% taking input from text file
[filename pathname]=uigetfile({'.txt'},'Browse the text file'); 
fulpathname=strcat(pathname,filename);
file=fulpathname;
 fileID = fopen(file);
  M = fscanf(fileID,'%c');
  
% msgbox('Encrption process has been started, it would take some time');
% M = input('\nEnter the message: ','s');
x=length(M)
c=0;
for j= 1:x
%     for i=0:122

%         if strcmp(M(j),char(i))
            c(j)=int8(M(j));
%         end
%     end
end

% disp('ASCII Code of the entered Message:');
% disp(c);


% % %Encryption
for j= 1:x
   cipher(j)= crypt(c(j),Pk,e); 
end
% disp('Cipher Text of the entered Message:');
% disp(cipher);

% Saving the encypted file
[file,path] = uiputfile('secret_message.txt','Save encrypted file');
fulpathname=strcat(path,file);

 file=fulpathname;
 fileID = fopen(file,'w');
 fwrite(fileID,[cipher]);
 
% saving the private key 

[file,path] = uiputfile('private_key.txt','Save Decryption key');
fulpathname=strcat(path,file);

 file=fulpathname;
 fileID = fopen(file,'w');
 p1=num2str(d);
 p2=num2str(Pk);
  secretkey=' ';
  secretkey=[secretkey,p1];
  secretkey=[secretkey,' '];
  secretkey=[secretkey,p2];
  
 fwrite(fileID,secretkey);
 
 msgbox('Encryption Completed, File is saved successfully');


% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function [Pk,Phi,d,e] = intialize(p,q)
clc;
disp('Intializing:');
Pk=p*q;
Phi=(p-1)*(q-1);
%Calculate the value of e
x=2;e=1;
while x > 1
    e=e+1;
    x=gcd(Phi,e);
end
%Calculate the value of d
i=1;
r=1;
while r > 0
    k=(Phi*i)+1;
    r=rem(k,e);
    i=i+1;
end
d=k/e;
clc;
% disp(['The value of (N) is: ' num2str(Pk)]);
% disp(['The public key (e) is: ' num2str(e)]);
% disp(['The value of (Phi) is: ' num2str(Phi)]);
% disp(['The private key (d)is: ' num2str(d)]);


function a = dec2bin(d)
i=1;
a=zeros(1,65535);  % a is 1d matrix having only zeros
while d >= 2
    r=rem(d,2);
    if r==1
        a(i)=1;
    else
        a(i)=0;
    end
    i=i+1;
    d=floor(d/2);
end
if d == 2
    a(i) = 0;
else
    a(i) = 1;
end
x=[a(16) a(15) a(14) a(13) a(12) a(11) a(10) a(9) a(8) a(7) a(6) a(5) a(4) a(3) a(2) a(1)];


function mc = crypt(M,N,e)
%{
e=dec2bin(e);
k = 65535;
c  = M;
cf = 1;
cf=mod(c*cf,N);
for i=k-1:-1:1
    c = mod(c*c,N);
    j=k-i+1;
     if e(j)==1
         cf=mod(c*cf,N);
     end
end
mc=cf;
%}
c=1;
for i=1:e
    c=mod((c*M),N);
    
end
% c=mod(c,N);
mc=c;



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)

% Output folder
global outputFolder;
msgbox('Hiding procedure has been started');  
outputFolder = fullfile(cd, 'frames');    %directory in which this(stehanography.m) file is saved
if ~exist(outputFolder, 'dir')
mkdir(outputFolder);  % make directory
end

global mov; 

%getting no of frames
 % to access global variable
numberOfFrames = mov.NumberOfFrames;
numberOfFramesWritten = 0;
% global usedFrame;
usedFrame=0;   %to count the no of frames use to hide

for frame = 1 :numberOfFrames

thisFrame = read(mov, frame);
outputBaseFileName = sprintf('%d.png', frame);
outputFullFileName = fullfile(outputFolder, outputBaseFileName);
imwrite(thisFrame, outputFullFileName, 'png');
progressIndication = sprintf('Wrote frame %4d of %d.', frame,numberOfFrames);
disp(progressIndication);
numberOfFramesWritten = numberOfFramesWritten + 1;
end
progressIndication = sprintf('Wrote %d frames to folder "%s"',numberOfFramesWritten, outputFolder);
disp(progressIndication); 
 numberOfFramesWritten=0;   % as it will be used to write the stego frames
% output folder is same as input folder


msg1='';
global select
if select==1   % to hide text in video
% to read data from  text file
display('text')
% taking input from text file
[filename, pathname]=uigetfile({'.txt'},'Browse the text file to hide'); 
fulpathname=strcat(pathname,filename);
file=fulpathname;
 fileID = fopen(file);
msg1 = fscanf(fileID,'%c');

end


if select ==2 % to hide the image in video
display('image');
    [filename ,pathname]=uigetfile({'.'},'Browse the image to hide'); 
fulpathname=strcat(pathname,filename);
file=fulpathname;

M = imread(file);
[w ,h]=size(M);

M1=M(:,:,1);
M2=M(:,:,2);
M3=M(:,:,3);

cipher_text='';
[m ,n]=size(M1);
 

 for i=1:m
for j= 1:n

msg1=[msg1,char(M1(i,j))];
end
end

for i=1:m
for j= 1:n

msg1=[msg1,char(M2(i,j))];
end
end

for i=1:m
for j= 1:n

msg1=[msg1,char(M3(i,j))];

end
end

end
x1=length(msg1);
 msg=dec2base(msg1, 2,14);
 
[m n]=size(msg)% to calculate the size of matrix
a=1;
 b=7; % as msg data is represent in 14 bits and 1st 6 bits are of no use(as the are 0)

% start hiding data
add2=0;  % initializing frame url part
for frame=1:numberOfFrames

    if(a<m && b<n)

        display('Data is hiding in new frame');
 add1='';
 outputFolder = fullfile(cd, 'frames');
 add1=[add1,outputFolder];
   add1=[add1,'\'];
% add1='C:\Users\Ekansh\Desktop\ekansh\project\frames\';
    add2=add2+1;% to increment the frame no so that new frame can be access each time
   add3=num2str(add2);
    add4='.png';
    add=[add1,add3,add4]

imdata = imread(add);
 liftscheme = liftwave('lazy','int2int');
 [cA cH cV cD]=lwt2(imdata,liftscheme);
 
%  global pixelused;
pixelused=0; % to count the no of pixels use to hide in last frame


% hiding data in cA
R = cA(:,:,1); % Get the RED matrix
G = cA(:,:,2); % Get the GREEN matrix
B = cA(:,:,3); % Get the BLUE matrix
 
% hiding data in R of cA
 [m1 n1]=size(R);
 R1=R;
  display('hiding data in R of cA ')
 for i=1:m1
 for j=1:n1
     if(a<=m)
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 1,c);
            b=b+1;
       pixelused=pixelused+1;
         else
             if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=R(i,j);
            R(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end
       end
 end
 end
  
% to check whether data is left for hiding 

% hiding data in G of cA
if(a<=m|| b<=n)
 display('hiding data in G of cA ')
G = cA(:,:,2); % Get the GREEN matrix
 
 [m1 n1]=size(G);
 G1=G;

 for i=1:m1
 for j=1:n1
     if(a<=m)
          %display('hhhhhhhhhhhhhhhhhhhhhhh')
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=G(i,j);
            G(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=G(i,j);
            G(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else  if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=G(i,j);
            G(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=G(i,j);
            G(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end
      end
 end
end
end

% to check whether data is left for hiding

% hiding data in B of cA
if(a<=m|| b<=n)

 display('hiding data in B of cA ')
 B = cA(:,:,3); % Get the BLUE matrix
 
 [m1 n1]=size(B);
 B1=B;

 for i=1:m1
 for j=1:n1
     if(a<=m)
         %display('hhhhhhhhhhhhhhhhhhhhhhh')
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=B(i,j);
            B(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=B(i,j);
            B(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=B(i,j);
            B(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=B(i,j);
            B(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end
        end
 end
 end
end



% to recover CA band from RGB
CA = cat(3, R, G, B);
% to check whether data is left for hiding


% hiding data in cH
R = cH(:,:,1); % Get the RED matrix
%G = cH(:,:,2); % Get the GREEN matrix
%B = cH(:,:,3); % Get the BLUE matrix
 
 
 % hiding data in R of cH
 [m1 n1]=size(R);
 R1=R;
 
 if(a<=m|| b<=n)
 display('hiding data in R of cH ')     
 for i=1:m1
 for j=1:n1
     if(a<=m)
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=R(i,j);
            R(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
             R(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end
         end
 end
 end
 end

 
        
% to check whether data is left for hiding 

% hiding data in G of cH
if(a<=m|| b<=n)
 display('hiding data in G of cH ')
G = cH(:,:,2); % Get the GREEN matrix
 
 [m1 n1]=size(G);
 G1=G;

 for i=1:m1
 for j=1:n1
     if(a<=m)
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=G(i,j);
            G(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=G(i,j);
            G(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=G(i,j);
            G(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
           d=G(i,j);
            G(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end
          end
 end
end
end


% to check whether data is left for hiding

% hiding data in B of cH
if(a<=m|| b<=n)

 display('hiding data in B of cH ')
 B = cH(:,:,3); % Get the BLUE matrix
 
 [m1 n1]=size(B);
 B1=B;

 for i=1:m1
 for j=1:n1
     if(a<=m)
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=B(i,j);
            B(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=B(i,j);
            B(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=B(i,j);
            B(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=B(i,j);
            B(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end
          end
 end
 end
end

% to recover CH band from RGB


CH = cat(3, R, G, B);
% to check whether data is left for hiding


% hiding data in cV
R = cV(:,:,1); % Get the RED matrix
%G = cV(:,:,2); % Get the GREEN matrix
%B = cV(:,:,3); % Get the BLUE matrix
 
 
 % hiding data in R of cV
 [m1 n1]=size(R);
 R1=R;
 
 if(a<=m|| b<=n)
 display('hiding data in R of cV ')     
 for i=1:m1
 for j=1:n1
     if(a<=m)
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=R(i,j);
            R(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end
          end
 end
 end
 end
 
        
% to check whether data is left for hiding 

% hiding data in G of cV
if(a<=m|| b<=n)
 display('hiding data in G of cV ')
G = cV(:,:,2); % Get the GREEN matrix
 
 [m1 n1]=size(G);
 G1=G;

 for i=1:m1
 for j=1:n1
     if(a<=m)
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=G(i,j);
            G(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=G(i,j);
            G(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=G(i,j);
            G(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=G(i,j);
            G(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end  
     end
 end
end
end


% to check whether data is left for hiding

% hiding data in B of cV
if(a<=m|| b<=n)

 display('hiding data in B of cV ')
 B = cV(:,:,3); % Get the BLUE matrix
 
 [m1 n1]=size(B);
 B1=B;

 for i=1:m1
 for j=1:n1
     if(a<=m)
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=B(i,j);
            B(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=B(i,j);
            B(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=B(i,j);
            B(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
             d=B(i,j);
            B(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end
       end
 end
 end
end

% to recover CV band from RGB
CV = cat(3, R, G, B);


% to check whether data is left for hiding


% hiding data in cD
R = cD(:,:,1); % Get the RED matrix
%G = cD(:,:,2); % Get the GREEN matrix
%B = cD(:,:,3); % Get the BLUE matrix
 
 
 % hiding data in R of cD
 [m1 n1]=size(R);
 R1=R;
 
 if(a<=m|| b<=n)
 display('hiding data in R of cD ')     
 for i=1:m1
 for j=1:n1
     if(a<=m)
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=R(i,j);
            R(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=R(i,j);
            R(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end
      end
 end
 end
 end


 
        
% to check whether data is left for hiding 

% hiding data in G of cD
if(a<=m|| b<=n)
 display('hiding data in G of cD ')
G = cD(:,:,2); % Get the GREEN matrix
 
 [m1 n1]=size(G);
 G1=G;

 for i=1:m1
 for j=1:n1
     if(a<=m)
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=G(i,j);
            G(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=G(i,j);
            G(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=G(i,j);
            G(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
             d=G(i,j);
            G(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
         end
      end
 end
end
end


% to check whether data is left for hiding

% hiding data in B of cD
if(a<=m|| b<=n)

 display('hiding data in B of cD ')
 B = cD(:,:,3); % Get the BLUE matrix
 
 [m1 n1]=size(B);
 B1=B;

 for i=1:m1
 for j=1:n1
     if(a<=m)
         if(b<n)
            c=msg(a,b);
            c = str2num(c);
            d=B(i,j);
            B(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
           d=B(i,j);
            B(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
         else if(a~=m)
             a=a+1;
             b=7;
              c=msg(a,b);
              c = str2num(c);
              d=B(i,j);
            B(i,j)= bitset(d, 2,c ) ;
            b=b+1;
            c=msg(a,b);
            c = str2num(c);
            d=B(i,j);
            B(i,j)= bitset(d, 1,c);
            b=b+1;
             pixelused=pixelused+1;
             end
            end
         end
 end
 end
 end


% to recover CD band from RGB
CD = cat(3, R, G, B);


%x=ilwt2(imdata,liftscheme);
X=ilwt2(CA,CH,CV,CD,liftscheme);
 X=uint8(X);
 % imshow(X);
 

 %imwrite(X,'modified_image.png') 
 %thisFrame = read(mov, stegoframe);
outputBaseFileName = sprintf('%d.png', frame);
outputFullFileName = fullfile(outputFolder, outputBaseFileName);
imwrite(X, outputFullFileName, 'png');
progressIndication = sprintf('Wrote frame %4d of %d.', frame,numberOfFrames);
disp(progressIndication);
numberOfFramesWritten = numberOfFramesWritten + 1;
 
 usedFrame=usedFrame+1
 
 
    end
    if b==15
        b=7;
    end
end
pixelused
% workingDir = tempname;
 outputFolder = fullfile(cd); %to change the directory i.e. back to one folder

workingDir=outputFolder;
% workingDir='C:\Users\Ekansh\Desktop\ekansh\project\final ppt';

% mkdir(workingDir);

% Read and Sort the Image Sequence 
imageNames = dir(fullfile(workingDir,'frames','*.png'));
imageNames = {imageNames.name}';


%  First, match any file names that contain a sequence of numeric digits. Convert the strings to doubles.
imageStrings = regexp([imageNames{:}],'(\d*)','match');
imageNumbers = str2double(imageStrings);

% Sort the frame numbers from lowest to highest. The sort function returns an index matrix that indicates how to order the associated files.

[~,sortedIndices] = sort(imageNumbers);
sortedImageNames = imageNames(sortedIndices);


%  Construct a VideoWriter object, which creates a Motion-JPEG AVI file by default.
global fulpathname1;
inputVideo = VideoReader(fulpathname1);
outputVideo = VideoWriter(fullfile(workingDir,'eku.avi'));
outputVideo.FrameRate = inputVideo.FrameRate;
open(outputVideo);

% Loop through the image sequence, load each image, and then write it to the video.

for ii = 1:numberOfFrames     %no of frames 
    img = imread(fullfile(workingDir,'frames',sortedImageNames{ii}));

    writeVideo(outputVideo,img);
end

video.MultimediaFileWriter;
% Finalize the video file.
close(outputVideo);



%To get audio alone from the file
% file='C:\Users\Ekansh\Desktop\ekansh\project\final ppt\sample.avi';
%  file='C:\Users\Ekansh\Desktop\ekansh\project\final ppt\Complete_project\work\sample videos\sample1.wmv';
file1='audio.wav'; %o/p file name
file=fulpathname1;
hmfr=video.MultimediaFileReader(file,'AudioOutputPort',true,'VideoOutputPort',false);
 hmfw = video.MultimediaFileWriter(file1,'AudioInputPort',true,'VideoInputPort',false);

 q=4;
 flag=0;
 while ~isDone(hmfr)
 	 audioFrame = step(hmfr);
      audioFrame(1,1)=usedFrame;
      
      if pixelused>32767
           flag=1;
          while pixelused>0
              audioFrame(q,1)=int16(pixelused);
              pixelused=pixelused-32767;
             q=q+1;
          end
           
      else
  
      audioFrame(q,1)=int16(pixelused);
      end
           if flag==1
               audioFrame(1,2)=q-1;
           else
               audioFrame(1,2)=q;
           end
     if(select==1)
      audioFrame(2,1)=1;      
     end
     if select==2
         audioFrame(2,1)=2;
         audioFrame(3,1)=w;
         audioFrame(3,2)=h;
      end
      
      
step(hmfw,int16(audioFrame));
 end
release(hmfw);
release(hmfr);

% [y,Fs] = mmreader('C:\Users\Ekansh\Desktop\ekansh\project\final ppt\audio.wav');


 ex_combine_video_and_audio_streams;

% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)


% extracting the sound component
% global mov;
global pixelused1;
pixelused1=0;
global fulpathname;
 file=fulpathname;
% file1='audio.wav'; %o/p file name
hmfr=video.MultimediaFileReader(file,'AudioOutputPort',true,'VideoOutputPort',false);
 	 audioFrame = step(hmfr);
      usedFrame=audioFrame(1,1);
      q=audioFrame(1,2);

      for q1=4:q
      pixelused1 = pixelused1 + double(audioFrame(q1,1));
      end
      
      hidden_file=audioFrame(2,1);
     w=audioFrame(3,1);
     h=audioFrame(3,2);
     if hidden_file==1
         msgbox('hidden file is text file');
         
     end
     if hidden_file==2
        msgbox('hidden file is image file');
     end

release(hmfr);

global outputFolder;
add2=0; % initializing frame url part
 message='';% initializing the variable to empty which will store the message
 a=1;
 b=1;
 if(usedFrame>1)
 
for stegoframe=1:(usedFrame-1)    % as in  last frame data is hidden in some pixels 
 
%      if(a<m && b<n)
         add1='';
 outputFolder = fullfile(cd, 'frames');
 add1=[add1,outputFolder];
   add1=[add1,'\'];
    add2=add2+1;% to increment the frame no so that new frame can be access each time
   add3=num2str(add2);
    add4='.png';
    add=[add1,add3,add4]

     imdata=imread(add);
 liftscheme = liftwave('lazy','int2int');
 [cA1 cH1 cV1 cD1]=lwt2(imdata,liftscheme);

 
 
 % extracting message from R component of cA1
 
 R2 = cA1(:,:,1); % Get the RED matrix
                        
 [m1 n1]=size(R2);
 a=1;
 b=1;
 k=1;
c=0;
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=R2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
 
    
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 
 
 % extracting message from R component of cA1
 
 
   G2 = cA1(:,:,2); % Get the Green matrix
                        
 [m1 n1]=size(G2);
 a=1;
 b=1;
 k=1;
c=0;
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=G2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
 
    
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end

% extracting message from B component of cA1
 
 
   B2 = cA1(:,:,3); % Get the Blue matrix
                        
 [m1 n1]=size(B2);
 
 b=1;
 k=1;
c=0;
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=B2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
 
    
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
% now from cH1 band 
% extracting message from R component 
 

 R2 = cH1(:,:,1); % Get the RED matrix
                        
 [m1 n1]=size(R2);
 a=1;
 b=1;
 k=1;
c=0;
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=R2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
 
    
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);
 

 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 
 
 % extracting message from R component of cH1
 
 
   G2 = cH1(:,:,2); % Get the Green matrix
                        
 [m1 n1]=size(G2);
 
 b=1;
 k=1;
c=0;
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=G2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
 
    
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end

% extracting message from B component of cH1
 
 
   B2 = cH1(:,:,3); % Get the Blue matrix
                        
 [m1 n1]=size(B2);
 a=1;
 b=1;
 k=1;
 c=0;
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=B2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
 
    
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 
 
 % now from cV1 component
  % extracting message from R
 
 R2 = cV1(:,:,1); % Get the RED matrix
                        
 [m1 n1]=size(R2);
 a=1;
 b=1;
 k=1;
 c=0;
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=R2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
 
    
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);
 

 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 
 
 % extracting message from G component 
 
   G2 = cV1(:,:,2); % Get the Green matrix
                        
 [m1 n1]=size(G2);
 a=1;
 b=1;
 k=1;
c=0;
 for i=1:m1
 for j=1:n1
    
             
            pixelval=G2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
 
    
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end

% extracting message from B component 
 
 
   B2 = cV1(:,:,3); % Get the Blue matrix
                        
 [m1 n1]=size(B2);
 a=1;
 b=1;
 k=1;
c=0;
 for i=1:m1
 for j=1:n1
    
             
            pixelval=B2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
 
    
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 % now from cD1 component
  % extracting message from R
 
 R2 = cD1(:,:,1); % Get the RED matrix
                        
 [m1 n1]=size(R2);
 a=1;
 b=1;
 k=1;
c=0;
for i=1:m1
 for j=1:n1
    
             
            pixelval=R2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
 
    
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);
 

 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 
 
 % extracting message from G component 
 
   G2 = cD1(:,:,2); % Get the Green matrix
                        
 [m1 n1]=size(G2);
 a=1;
 b=1;
 k=1;
c=0; 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=G2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end

% extracting message from B component 
 
 
   B2 = cD1(:,:,3); % Get the Blue matrix
                        
 [m1 n1]=size(B2);
 a=1;
 b=1;
 k=1;
c=0;
 for i=1:m1
 for j=1:n1
    
             
            pixelval=B2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          
          if(b==9)
             b=1;
             k=k+1;
          end
          
                 
 end
 end
 
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s-1
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
     end
  end
%  usedFrame
 
[message]=extracting_message_from_last(usedFrame,message);   % calling the function which extract the message from the last frame which is used for hiding the message
 


 prompt = {'Enter 1 to for text filee and 2 for an image '};
dlg_title = 'Input';
num_lines = 1;
def = {'1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
val = str2num(answer{1});


if val==1
 % Saving the encypted file
[file,path] = uiputfile('retrieve_message.txt','Save extracted message');
fulpathname=strcat(path,file);

 file=fulpathname;
 fileID = fopen(file,'w');
 fwrite(fileID,message);
 msgbox('Data is extracted successfully, file has been saved');
end


if val==2
    h=h/3;
    l=length(message)
    k=1;
    for i=1:w
        for j=1:h
            M1(i,j)=double(message(k));
        k=k+1;
        end
        
    end
    
   
    for i=1:w
        for j=1:h
            M2(i,j)=double(message(k));
        k=k+1;
        end
        
    end
    
    for i=1:w
        for j=1:h
            M3(i,j)=double(message(k));
        k=k+1;
        end
        
    end
    
    k=k
    
M=cat(3,M1,M2,M3);
M=uint8(M);
[file,path] = uiputfile('extracted_image.png','Save extracted_image');
outputFullFileName=strcat(path,file);

% outputFullFileName='C:\Users\Ekansh\Desktop\original_image.png';
imwrite(M, outputFullFileName, 'png');    
    
    
    
end



    




function[message]=extracting_message_from_last(usedFrame,message)

global outputFolder;
global pixelused1; 
add1='';

 outputFolder = fullfile(cd, 'frames');
 add1=[add1,outputFolder];
   add1=[add1,'\'];
    add2=usedFrame; % to select the last frame in which data is hidden
   add3=num2str(add2);
    add4='.png';
    add=[add1,add3,add4]


imdata = imread(add);
 liftscheme = liftwave('lazy','int2int');
 [cA1 cH1 cV1 cD1]=lwt2(imdata,liftscheme);
 
 pixelused1=pixelused1-1; % position upto which data is hidden in last frame

 pixelused2=0;
flag=1; 
 % extracting message from R component of cA1
 
 R2 = cA1(:,:,1); % Get the RED matrix
                        
 [m1 n1]=size(R2);
 a=1;
 b=1;
 k=1;
c=0;
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=R2(i,j);
          c(k,b)=bitget(pixelval,2);
          b=b+1;       
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
              flag=0;
              break
          end
                 
 end
 
 if flag==0
     break
 end
 end
  pixelused2
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);
 

 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 
 
 % extracting message from G component of cA1
 
if flag==1 
   G2 = cA1(:,:,2); % Get the Green matrix
                        
 [m1 n1]=size(G2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=G2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
               flag=0;
              break
          end
          
                 
 end
 
 if flag==0
     break
 end
 
 end
%  pixelused2
 
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);
 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
end



if flag==1
% extracting message from B component of cA1
 
 
   B2 = cA1(:,:,3); % Get the Blue matrix
                        
 [m1 n1]=size(B2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=B2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
               flag=0;
              break
          end
                 
 end
 
 if flag==0
     break
 end
  
 end
%    pixelused2
 
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
end
 
% now from cH1 band 
% extracting message from R component 
 
if flag==1
 R2 = cH1(:,:,1); % Get the RED matrix
                        
 [m1 n1]=size(R2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=R2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
        pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
               flag=0;
              break
          end
                 
 end
 
 if flag==0
     break
 end
 
 end
%    pixelused2
 
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
end
 
 % extracting message from G component of cH1
 
 if flag==1
   G2 = cH1(:,:,2); % Get the Green matrix
                        
 [m1 n1]=size(G2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=G2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
         pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
              
               flag=0;
              break
          end
          
                 
 end
 
 if flag==0
     break
 end
    
 end
%  pixelused2
 
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
end
 
 
% extracting message from B component of cH1
 
 if flag==1
   B2 = cH1(:,:,3); % Get the Blue matrix
                        
 [m1 n1]=size(B2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=B2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
         pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
               flag=0;
               
              break
          end
                 
 end
 if flag==0
     
     break
 end
  end
%    pixelused2
  
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);
 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 end
 
 % now from cV1 component
  % extracting message from R
 
  if flag==1
 R2 = cV1(:,:,1); % Get the RED matrix
                        
 [m1 n1]=size(R2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=R2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
         pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
               flag=0;
              break
          end
                 
 end
 if flag==0
    
     break
 end

 end
%  pixelused2
 
   
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
  
  end
 
 % extracting message from G component 
 
 if flag==1
   G2 = cV1(:,:,2); % Get the Green matrix
                        
 [m1 n1]=size(G2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=G2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
         pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
               flag=0;
              break
          end
                 
 end
 
 if flag==0
     break
 end
 end
%    pixelused2
  
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 end
% extracting message from B component 
 
 if flag==1
   B2 = cV1(:,:,3); % Get the Blue matrix
                        
 [m1 n1]=size(B2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=B2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
          pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
               flag=0;
              break
          end 
 end

 if flag==0
     break
 end
 end
%    pixelused2
  
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 end
 
 % now from cD1 component
  % extracting message from R
 if flag==1
 R2 = cD1(:,:,1); % Get the RED matrix
                        
 [m1 n1]=size(R2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=R2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
         pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
               flag=0;
              break
          end
                 
 end

 if flag==0
     break
 end
 end
    pixelused2
 
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end
 
 end
 
 % extracting message from G component 
 if flag==1
   G2 = cD1(:,:,2); % Get the Green matrix
                        
 [m1 n1]=size(G2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=G2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
         pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
               flag=0;
              break
          end
                 
 end
 
 if flag==0
     break
 end
 end
%   pixelused2
   
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end

 end
% extracting message from B component 
 
 if flag==1
   B2 = cD1(:,:,3); % Get the Blue matrix
                        
 [m1 n1]=size(B2);
 a=1;
 b=1;
 k=1;
 c=0;
% c(m1,n1);
 

 for i=1:m1
 for j=1:n1
    
             
            pixelval=B2(i,j);
           % pixelbin=dec2bin(pixelval,8);
          c(k,b)=bitget(pixelval,2);
      
          b=b+1;
          c(k,b)=bitget(pixelval,1);
          
          b=b+1;
        pixelused2=pixelused2+1;
          if(b==9)
             b=1;
             k=k+1;
          end
          if pixelused2>pixelused1
               flag=0;
          
              break
          end
                 
 end
 
 if flag==0
     break
 end
  end
 
    
 str = num2str(c);
% str=cellstr(str);
 str=char(bin2dec(str));
 
 s=size(str);


 for i=1:s
    message=[message,str(i)];
    
    % message=strcat(message,str(i))
 end

 end
    
%  pixelused2
    
 
 
 
 
 
     
 % hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)

% to encrypt the image
clear all; 
% close all;

prompt = {'Enter the key'};
dlg_title = 'Input';
num_lines = 1;
def = {'ekansh'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
key = (answer{1});
% q = str2num(answer{2});
% [Pk,Phi,d,e] = intialize(p,q);


% taking input as the image file
[filename pathname]=uigetfile({'.'},'Browse the image to encrypt'); 
fulpathname=strcat(pathname,filename);
file=fulpathname;

M = imread(file);
% outputFullFileName='C:\Users\Ekansh\Desktop\gray.png';
% imwrite(M, outputFullFileName, 'png');
% msgbox('Encrption process has been started, it would take some time');
% M = input('\nEnter the message: ','s');
M1=M(:,:,1);
M2=M(:,:,2);
M3=M(:,:,3);

cipher_text='';
[m n]=size(M1);

 
% % %Encryption
l=length(key);
l1=1;
k=1;
for i=1:m
for j= 1:n
%   for j1=1:n1

%    cipher(k)= crypt(double(M1(i,j)),Pk,e);
  
M1(i,j)= bitxor(double(key(l1)),M1(i,j));
l1=l1+1;
if(l1>l)
    l1=1;
%     key=key+1;
end
  k=k+1;
% end
end
end

% cipher_text=[cipher_text,cipher];
[m n]=size(M2);
l1=1;
k=1;
for i=1:m
for j= 1:n
%   for j1=1:n1

%    cipher(k)= crypt(double(M1(i,j)),Pk,e);
  
M2(i,j)= bitxor(double(key(l1)),M2(i,j));
l1=l1+1;
if(l1>l)
    l1=1;
%     key=key+1;
end
  k=k+1;
% end
end
end

% cipher_text=[cipher_text,cipher];
[m n]=size(M3);
l1=1;
k=1;
for i=1:m
for j= 1:n
%   for j1=1:n1

%    cipher(k)= crypt(double(M1(i,j)),Pk,e);
  
M3(i,j)= bitxor(double(key(l1)),M3(i,j));
l1=l1+1;
if(l1>l)
    l1=1;
%     key=key+1;
end
  k=k+1;
% end
end
end
M=cat(3,M1,M2,M3);


[file,path] = uiputfile('encrpted_image.png','Save encrypted image');
outputFullFileName=strcat(path,file);


% outputFullFileName='C:\Users\Ekansh\Desktop\gray.png';
imwrite(M, outputFullFileName, 'png');


[file,path] = uiputfile('decrytion_key.txt','Save decyption key');
outputFullFileName=strcat(path,file);

 fileID = fopen(outputFullFileName,'w');
 fwrite(fileID,[key]);


msgbox('Encryption Completed, File is saved successfully');


% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes when selected object is changed in uipanel7.
function uipanel7_SelectionChangeFcn(hObject, eventdata, handles)
global select

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    
    case 'radiobutton12'
        display('Text is selected');
        select=1
    case 'radiobutton13'
         display('image is selected');
        select=2
     
end

% hObject    handle to the selected object in uipanel7 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in uipanel8.
function uipanel8_SelectionChangeFcn(hObject, eventdata, handles)



global select

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    
    case 'radiobutton14'
        display('Text is selected');
        select=1
    case 'radiobutton15'
         display('image is selected');
        select=2
     
end
% hObject    handle to the selected object in uipanel8 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
