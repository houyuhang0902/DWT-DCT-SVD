function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
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
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 24-May-2021 13:37:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% Image=imread('lena.png');
% axes(handles.axes1)
% imshow(Image)
% Water=imread('water.png');
% axes(handles.axes3)
% imshow(Water)

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
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
% Image=imread('lena.png');
% Water=imread('water.png');
global src_image;
global src_water;
Image=src_image;
Water=src_water;
[Iwm,Uw,Vw]=EmbedWatermark(Image,Water);
PSNR=RGBPSNR(Image, uint8(Iwm));
set(handles.text9,'String',num2str(PSNR))
axes(handles.axes2)
imshow(uint8(Iwm))
[filename,pathname] = uiputfile({'*.*';'*.jpg';'*.bmp';'*.gif';'*.png';'*.tif'},'Put Pic');
if(filename ~= 0)
str = [pathname filename];
imwrite(uint8(Iwm),str)
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Image=imread('lena.png');
% Water=imread('water.png');
global src_image;
global src_water;
Image=src_image;
Water=src_water;
[Iwm,Uw,Vw]=EmbedWatermark(Image,Water);
switch get(handles.popupmenu1,'value')
    case 1
    case 2
        number2 = floor(get(handles.slider2,'value')*100);
        if number2==0
            number2 = number2+1;
        end
        Iwm = JPEG2000Attack(Iwm,number2);
    case 3
        number3 = floor(get(handles.slider3,'value')*100);
        Iwm = JPEGAttack(Iwm,number3);
    case 4
        if get(handles.radiobutton1,'value') == 1
            number4 = 1;
        elseif get(handles.radiobutton2,'value') == 1
            number4 = 2;
        else
            number4 = 3;
        end
        Iwm = noiseAttack(Iwm,number4);
    case 5
        if get(handles.radiobutton4,'value') == 1
            number5 = 1;
        elseif get(handles.radiobutton5,'value') == 1
            number5 = 2;
        else
            number5 = 3;
        end
        Iwm = FilterAttack(Iwm,number5);
    case 6
        Iwm = SharpenAttack(Iwm);
    case 7
        Iwm = histeqAttack(Iwm);
end
[WaterR,WaterG,WaterB]=ExtractWatermark(Iwm,Image,Uw,Vw,Water);
axes(handles.axes4)
NCR=ncc(uint8(WaterR),Water);
NCG=ncc(uint8(WaterG),Water);
NCB=ncc(uint8(WaterB),Water);
a=[NCR,NCG,NCB];
[m,p]=max(a);
if p==1
    imshow(uint8(WaterR))
elseif p==2
    imshow(uint8(WaterG))
else
    imshow(uint8(WaterB))
end
set(handles.text2,'String',num2str(NCR))
set(handles.text3,'String',num2str(NCG))
set(handles.text4,'String',num2str(NCB))
msg=msgbox('水印提取完成','完成');


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num = get(handles.popupmenu1,'value');
if num == 2
    set(handles.slider3,'visible','off');
    set(handles.text11,'visible','off');
    set(handles.uibuttongroup2,'visible','off');
    set(handles.uibuttongroup3,'visible','off');
    set(handles.slider2,'visible','on');
    set(handles.text10,'visible','on');
elseif num == 3
    set(handles.slider2,'visible','off');
    set(handles.text10,'visible','off');
    set(handles.uibuttongroup2,'visible','off');
    set(handles.uibuttongroup3,'visible','off');
    set(handles.slider3,'visible','on');
    set(handles.text11,'visible','on');
elseif num == 4
    set(handles.slider3,'visible','off');
    set(handles.text11,'visible','off');
    set(handles.slider2,'visible','off');
    set(handles.text10,'visible','off');
    set(handles.uibuttongroup3,'visible','off');
    set(handles.uibuttongroup2,'visible','on');
    set(handles.radiobutton1,'visible','on');
    set(handles.radiobutton2,'visible','on');
    set(handles.radiobutton3,'visible','on');
elseif num == 5
    set(handles.slider3,'visible','off');
    set(handles.text11,'visible','off');
    set(handles.slider2,'visible','off');
    set(handles.text10,'visible','off');
    set(handles.uibuttongroup2,'visible','off');
    set(handles.uibuttongroup3,'visible','on');
    set(handles.radiobutton4,'visible','on');
    set(handles.radiobutton5,'visible','on');
    set(handles.radiobutton6,'visible','on');
else
    set(handles.slider3,'visible','off');
    set(handles.text11,'visible','off');
    set(handles.slider2,'visible','off');
    set(handles.text10,'visible','off');
    set(handles.uibuttongroup2,'visible','off');
    set(handles.uibuttongroup3,'visible','off');
end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile({'*.*';'*.jpg';'*.bmp';'*.gif';'*.png';'*.tif'},'Read Pic');
str = [pathname filename];
global src_image;
if ~isequal([pathname,filename],[0,0])
    src_image = imread(str);
    axes(handles.axes1);
    imshow(src_image);
end
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile({'*.*';'*.jpg';'*.bmp';'*.gif';'*.png';'*.tif'},'Read Pic');
str = [pathname filename];
global src_water;
if ~isequal([pathname,filename],[0,0])
    src_water = imread(str);
    axes(handles.axes3);
    imshow(src_water);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
