function varargout = SignDetector(varargin)
% SIGNDETECTOR MATLAB code for SignDetector.fig
%      SIGNDETECTOR, by itself, creates a new SIGNDETECTOR or raises the existing
%      singleton*.
%
%      H = SIGNDETECTOR returns the handle to a new SIGNDETECTOR or the handle to
%      the existing singleton*.
%
%      SIGNDETECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNDETECTOR.M with the given input arguments.
%
%      SIGNDETECTOR('Property','Value',...) creates a new SIGNDETECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SignDetector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SignDetector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SignDetector

% Last Modified by GUIDE v2.5 24-Sep-2013 00:43:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SignDetector_OpeningFcn, ...
                   'gui_OutputFcn',  @SignDetector_OutputFcn, ...
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


% --- Executes just before SignDetector is made visible.
function SignDetector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SignDetector (see VARARGIN)

% Choose default command line output for SignDetector
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SignDetector wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SignDetector_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function modelName_Callback(hObject, eventdata, handles)
% hObject    handle to modelName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of modelName as text
%        str2double(get(hObject,'String')) returns contents of modelName as a double


% --- Executes during object creation, after setting all properties.
function modelName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modelName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in imageOOI.
function imageOOI_Callback(hObject, eventdata, handles)
% hObject    handle to imageOOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global name;
global origImg;

contents = cellstr(get(hObject,'String'));
origName = contents{get(hObject,'Value')};
if ~strcmp(origName, '-')
origImg = imread([name '\images\' origName]);
imshow(origImg, 'parent', handles.originalImage);
axis off
displayFilteredImage(handles);
end

set(handles.hueLower, 'Enable', 'on');
set(handles.satLower, 'Enable', 'on');
set(handles.valLower, 'Enable', 'on');
set(handles.hueUpper, 'Enable', 'on');
set(handles.satUpper, 'Enable', 'on');
set(handles.valUpper, 'Enable', 'on');

set(handles.distThresh, 'Enable', 'on');
set(handles.extractBlobs, 'Enable', 'on');





% Hints: contents = cellstr(get(hObject,'String')) returns imageOOI contents as cell array
%        contents{get(hObject,'Value')} returns selected item from imageOOI


% --- Executes during object creation, after setting all properties.
function imageOOI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imageOOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function imagesPath_Callback(hObject, eventdata, handles)
% hObject    handle to imagesPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imagesPath as text
%        str2double(get(hObject,'String')) returns contents of imagesPath as a double


% --- Executes during object creation, after setting all properties.
function imagesPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagesPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function hueLower_Callback(hObject, eventdata, handles)
% hObject    handle to hueLower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
displayFilteredImage(handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function hueLower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hueLower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function satLower_Callback(hObject, eventdata, handles)
% hObject    handle to satLower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
displayFilteredImage(handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function satLower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to satLower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function valLower_Callback(hObject, eventdata, handles)
% hObject    handle to valLower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
displayFilteredImage(handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function valLower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valLower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function hueUpper_Callback(hObject, eventdata, handles)
% hObject    handle to hueUpper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
displayFilteredImage(handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function hueUpper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hueUpper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function satUpper_Callback(hObject, eventdata, handles)
% hObject    handle to satUpper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
displayFilteredImage(handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function satUpper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to satUpper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function valUpper_Callback(hObject, eventdata, handles)
% hObject    handle to valUpper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
displayFilteredImage(handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function valUpper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valUpper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function distThresh_Callback(hObject, eventdata, handles)
% hObject    handle to distThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distThresh as text
%        str2double(get(hObject,'String')) returns contents of distThresh as a double


% --- Executes during object creation, after setting all properties.
function distThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in extractBlobs.
function extractBlobs_Callback(hObject, eventdata, handles)
% hObject    handle to extractBlobs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global name;
global ext;
% This button extracts all blobs from each training image and saves it.
% First get threshold distance and the filtering parameters.
threshDist = str2double(get(handles.distThresh,'String'));
[hLow, hHigh, sLow, sHigh, vLow, vHigh] = getHSVLimits(handles);

% Use these parameters to filter and segment each image in the training
% folder
D = dir([name '\images\*' ext]);
for i = 1:length(D)
    img = imread([name '\images\' D(i).name]);
    [~, pixLoc] = filterImage(img, hLow, hHigh, sLow, sHigh, vLow, vHigh);
    [class, classes] = segmentImage(pixLoc, threshDist, 100);
%     After segmentation is done, cut out each blob and save to a file
    for j = 1:length(classes)
        pix = pixLoc(class == classes(j),:);
        xMin = min(pix(:,2));
        yMin = min(pix(:,1));
        rows = max(pix(:,1)) - yMin;
        cols = max(pix(:,2)) - xMin;
        blob = imcrop(uint8(img),[xMin, yMin, cols, rows]);
%         remember to trim off the extension from the filenames when saving
%         as blobs
        imwrite(blob, [name '\blobs\' D(i).name(1:end-length(ext)) '_blob_' num2str(j) ext]);
    end
%     update the progress text field
    set(handles.blobProgress, 'string', [num2str(round(i/length(D)*100)) '% complete']);
end





function blobHeight_Callback(hObject, eventdata, handles)
% hObject    handle to blobHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blobHeight as text
%        str2double(get(hObject,'String')) returns contents of blobHeight as a double


% --- Executes during object creation, after setting all properties.
function blobHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blobHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function blobWidth_Callback(hObject, eventdata, handles)
% hObject    handle to blobWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blobWidth as text
%        str2double(get(hObject,'String')) returns contents of blobWidth as a double


% --- Executes during object creation, after setting all properties.
function blobWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blobWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cellSize_Callback(hObject, eventdata, handles)
% hObject    handle to cellSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cellSize as text
%        str2double(get(hObject,'String')) returns contents of cellSize as a double


% --- Executes during object creation, after setting all properties.
function cellSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cellSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in labelData.
function labelData_Callback(hObject, eventdata, handles)
% hObject    handle to labelData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global name;
global ext;
global currentBlobName;
D = dir([name '\blobs\*' ext]);
if ~isempty(D)
    currentBlobName = D(1).name;
    imshow([name '\blobs\' currentBlobName], 'parent', handles.showBlob);
end



% --- Executes on button press in crossVal.
function crossVal_Callback(hObject, eventdata, handles)
% hObject    handle to crossVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global name;
load([name '\TrainingData.mat']);

numData = length(Truth);
numCorrect = 0;
for k = 1:numData
    xTrain = Data;
    yTrain = Truth;
    
    xTest = xTrain(k,:);
    yTest = yTrain(k,:);
    xTrain(k,:) = [];
    yTrain(k) = [];
    
    SVM = svmtrain(xTrain, yTrain, 'kernel_function', 'linear');
    
    g = svmclassify(SVM, xTest);
    if g > 0
        g = 1;
    else
        g = -1;
    end
    if g == yTest
        numCorrect = numCorrect + 1;
    end
    set(handles.cvProgress, 'string', [num2str(round(k / numData*100)) ' % complete']);
end

validResult = numCorrect / numData * 100;
set(handles.validResults, 'String', [num2str(validResult) ' %']);


% --- Executes on button press in trainFinal.
function trainFinal_Callback(hObject, eventdata, handles)
% hObject    handle to trainFinal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global name;
load([name '\TrainingData.mat']);

SVM = svmtrain(Data, Truth, 'kernel_function', 'linear');


% Get model info and parameters and save them to csv files.
% save SVM to .mat file
[hLow, hHigh, sLow, sHigh, vLow, vHigh] = getHSVLimits(handles);
threshDist = str2double(get(handles.distThresh,'String'));
blobWidth = str2double(get(handles.blobWidth, 'String'));
blobHeight = str2double(get(handles.blobHeight, 'String'));
cellSize = str2double(get(handles.cellSize, 'String'));

params = [hLow; hHigh; sLow; sHigh; vLow; vHigh; threshDist; blobWidth; blobHeight; cellSize];
supVects = SVM.SupportVectors;
alphas = SVM.Alpha;
bias = SVM.Bias;

modelParams = struct('hLow', hLow, 'hHigh', hHigh, 'sLow', sLow, ...
                'sHigh', sHigh, 'vLow', vLow, 'vHigh', vHigh, ...
                'distThresh', threshDist, 'blobWidth', blobWidth, ...
                'blobHeight', blobHeight, 'cellSize', cellSize);
            
save([name '\models\' name '_final.mat'], 'SVM', 'modelParams');

% Write to binary files

% write params to binary file
fid = fopen([name '\models\' name '_params.dat'], 'w');
fwrite(fid, params, 'int');
fclose(fid);

% write bias to binary file
fid = fopen([name '\models\' name '_bias.dat'], 'w');
fwrite(fid, bias, 'double');
fclose(fid);

% write alphas to binary file
fid = fopen([name '\models\' name '_alphas.dat'], 'w');
fwrite(fid, alphas, 'double');
fclose(fid);

% write supVects to binary file
fid = fopen([name '\models\' name '_supVects.dat'], 'w');
fwrite(fid, supVects, 'double');
fclose(fid);



% --- Executes on button press in newModel.
function newModel_Callback(hObject, eventdata, handles)
% hObject    handle to newModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global name;

name = get(handles.modelName,'String');

mkdir(name);
mkdir(name, 'blobs');
mkdir([name '\blobs'], 'pos');
mkdir([name '\blobs'], 'neg');
mkdir(name, 'images');
mkdir(name, 'models');

% Enable buttons etc...
set(handles.imagesPath, 'Enable', 'on');
set(handles.copyFiles, 'Enable', 'on');
set(handles.extensions, 'Enable', 'on');


% --- Executes on button press in copyFiles.
function copyFiles_Callback(hObject, eventdata, handles)
% hObject    handle to copyFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global name;
global ext;

% enable drop-down menu, slider bars, segmentation textbox, and blob button
set(handles.imageOOI, 'Enable', 'on');


% First get value of extensions pop-up menu
contents = cellstr(get(handles.extensions,'String'));
ext = contents{get(handles.extensions,'Value')};
% copy all files with extensions EXT to "images\" directory
copyfile([get(handles.imagesPath, 'string') '\*' ext], [name '\images']);
% populate the imageOOI popup menu
d = dir([name '\images\*' ext]);
filenames={d(~[d.isdir]).name};
set(handles.imageOOI, 'string', filenames);

% Enable UI controls that deal with training data so user can skip some
% steps

set(handles.labelData, 'Enable', 'on');
set(handles.posButton, 'Enable', 'on');
set(handles.negButton, 'Enable', 'on');

set(handles.blobHeight, 'Enable', 'on');
set(handles.blobWidth, 'Enable', 'on');
set(handles.cellSize, 'Enable', 'on');

set(handles.assembleTrainingData, 'Enable', 'on');
set(handles.crossVal, 'Enable', 'on');
set(handles.trainFinal, 'Enable', 'on');



%gets data from each slider for HSV limits and returns them
function [hLow, hHigh, sLow, sHigh, vLow, vHigh] = getHSVLimits(handles)
hLow = get(handles.hueLower, 'Value');
set(handles.hLow, 'string', num2str(round(hLow)));
hHigh = get(handles.hueUpper, 'Value');
set(handles.hHigh, 'string', num2str(round(hHigh)));
sLow = get(handles.satLower, 'Value');
set(handles.sLow, 'string', num2str(round(sLow)));
sHigh = get(handles.satUpper, 'Value');
set(handles.sHigh, 'string', num2str(round(sHigh)));
vLow = get(handles.valLower, 'Value');
set(handles.vLow, 'string', num2str(round(vLow)));
vHigh = get(handles.valUpper, 'Value');
set(handles.vHigh, 'string', num2str(round(vHigh)));

function displayFilteredImage(handles)
global origImg
%Gets info from all the slider bars and displays the filtered image
[hLow, hHigh, sLow, sHigh, vLow, vHigh] = getHSVLimits(handles);
[filtImg, pixLoc] = filterImage(origImg, hLow, hHigh, sLow, sHigh, vLow, vHigh);
imshow(filtImg, 'parent', handles.filteredImage);


% --- Executes on selection change in extensions.
function extensions_Callback(hObject, eventdata, handles)
% hObject    handle to extensions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns extensions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from extensions


% --- Executes during object creation, after setting all properties.
function extensions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to extensions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in posButton.
function posButton_Callback(hObject, eventdata, handles)
% hObject    handle to posButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global name;
global ext;
global currentBlobName;
movefile([name '\blobs\' currentBlobName], [name '\blobs\pos']);

D = dir([name '\blobs\*' ext]);
if ~isempty(D)    
    currentBlobName = D(1).name;
    imshow([name '\blobs\' currentBlobName], 'parent', handles.showBlob);
end


% --- Executes on button press in negButton.
function negButton_Callback(hObject, eventdata, handles)
% hObject    handle to negButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global name;
global ext;
global currentBlobName;
movefile([name '\blobs\' currentBlobName], [name '\blobs\neg']);

D = dir([name '\blobs\*' ext]);
if ~isempty(D)    
    currentBlobName = D(1).name;
    imshow([name '\blobs\' currentBlobName], 'parent', handles.showBlob);
end


% --- Executes on button press in assembleTrainingData.
function assembleTrainingData_Callback(hObject, eventdata, handles)
% hObject    handle to assembleTrainingData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global name;
global ext;
% Retrieve resizing and cell size data
cellSize = str2double(get(handles.cellSize, 'String'));
blobHeight = str2double(get(handles.blobHeight, 'String'));
blobWidth = str2double(get(handles.blobWidth, 'String'));
i = 1;
Data = [];
Truth = [];
% Assemble Positive training examples
D = dir([name '\blobs\pos\*' ext]);

for blobNum = 1:length(D)
    Image = imread([name '\blobs\pos\' D(blobNum).name]);
    Image = imresize(Image, [blobHeight, blobWidth], 'bil');
%     Fill in truth values
    Truth(i) = 1;
%     Extract HOG features from blob
    HOG1 = vl_hog(single(Image), cellSize);
%     Cast into a large data vector
    HOG1 = HOG1(:)';
%     assign each element to a column in Data(i,:)
    [~,d] = size(HOG1);
    for c = 1:d
        Data(i,c) = HOG1(c);
    end
    i = i+1;
end

% Assemble Negative training examples
D = dir([name '\blobs\neg\*' ext]);

for blobNum = 1:length(D)
    Image = imread([name '\blobs\neg\' D(blobNum).name]);
    Image = imresize(Image, [blobHeight, blobWidth], 'bil');
%     Fill in truth values
    Truth(i) = -1;
%     Extract HOG features from blob
    HOG1 = vl_hog(single(Image), cellSize);
%     Cast into a large data vector
    HOG1 = HOG1(:)';
%     assign each element to a column in Data(i,:)
    [~,d] = size(HOG1);
    for c = 1:d
        Data(i,c) = HOG1(c);
    end
    i = i+1;
end
Truth = Truth';
save([name '\TrainingData.mat'], 'Data', 'Truth');


% --- Executes during object creation, after setting all properties.
function originalImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to originalImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate originalImage


% --- Executes during object creation, after setting all properties.
function filteredImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filteredImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate filteredImage


% --- Executes during object creation, after setting all properties.
function showBlob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to showBlob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate showBlob


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
