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

% Last Modified by GUIDE v2.5 06-Nov-2022 20:10:18

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


global fpath

if fpath == 0
	fpath = './';
end

path = uigetdir(fpath)

if path ~= 0
	fpath = path;
	set( handles.edit9,'String', fpath );
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fpath
global prm
global prm_fd
global prm_hole
global prm_edge

%[csvfile, outpath, index] = uiputfile([fpath '/*.csv'], '出力CSVファイルを指定してください');
outpath = uigetdir(fpath);

if outpath == 0
	return;
end

outpath



prm_fd.fd.epsilon			= str2num( get(handles.edit3,'String') );
prm_fd.fd.window			= str2num( get(handles.edit4,'String') );

prm.offset.x(1)			= str2num( get(handles.edit5,'String') );
prm.offset.x(2)			= str2num( get(handles.edit6,'String') );
prm.offset.y(1)			= str2num( get(handles.edit7,'String') );
prm.offset.y(2)			= str2num( get(handles.edit8,'String') );

prm_fd.offset = prm.offset;
prm_hole.offset = prm.offset;
prm_edge.offset = prm.offset;


[ result_fd result_hole result_edge class flist ] = get_feature( fpath );

result_all = [ result_fd result_hole result_edge ];
Y = class;

[ Y2 Ycv model MAE_cv ds_cv id_select_best ] = LS_searchPrm( result_all, Y, prm );

plot_regression_result( Y2, Y, 1, [ outpath '/result_LSR_train.png'], '線形重回帰結果(教師データ)' );
plot_regression_result( Ycv, Y, 1, [ outpath '/result_LSR_cv.png'], '線形重回帰結果(LOO交差検定)' );

Y2_lr = sigmoid( Y2 );
Ycv_lr = sigmoid( Ycv );


model.prm_fd = prm_fd;
model.prm_hole = prm_hole;
model.prm_edge = prm_edge;

save( [ outpath '/model.mat' ], 'model' );
b_all = zeros( [ size( result_all, 2 ) 1 ] );

id_select = model.id_select
sid = size( id_select )

b = model.b
sb = size(b)

for ii=2:length(model.b)
	b_all( model.id_select(ii-1) ) = model.b(ii);
end

csvfile = fullfile(outpath, 'result.csv')
fp = fopen(csvfile,'wt');
fprintf( fp, ',,,');
output_header( fp, 'FD', prm_fd.edges );
output_header( fp, 'HOLES', prm_hole.edges );
output_header( fp, 'EDGES', prm_edge.edges );
fprintf( fp, '\n');

fprintf( fp, ',,mean,');
for ii=1:length(b_all)
	fprintf(fp,'%f,', mean(result_all(:,ii),1) );
end
fprintf( fp, '\n');

fprintf( fp, ',,std,');
for ii=1:length(b_all)
	fprintf(fp,'%f,', std(result_all(:,ii),1) );
end
fprintf( fp, '\n');

fprintf( fp, ',,weight,');
for ii=1:length(b_all)
	fprintf(fp,'%f,', b_all(ii) );
end
fprintf( fp, '\n');

fprintf( fp, '\nfilename,Likelihood(train),Likelihood(LOOCV)\n');
for i1=1:length(flist)
	[filepath,name,ext] = fileparts( flist(i1).filename );
	fprintf(fp,'%s,%f,%f,', name, Y2_lr(i1), Ycv_lr(i1) );
	for i2 = 1:size( result_all,2 )
		fprintf(fp,'%d,', result_all(i1,i2) );
	end
	fprintf( fp, '\n');
end

fclose(fp)


if get( handles.radiobutton1, 'Value') == 1
	%結果を可視化
	rmin = min( Y2_lr(:) );
	rmax = max( Y2_lr(:) );

	emin = floor(rmin*10)*0.1;
	emax = ceil(rmax*10)*0.1;
	edges = [ emin:0.025:emax ];
	show_result( flist, edges, Y2_lr, [ outpath '/sort_images.png' ] );
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% モデル選択 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fpath
global model

if fpath == 0
	fpath = './';
end

[file,path,indx]  = uigetfile( [fpath '/*.mat'] );

if indx ~= 0
	file_mat = [ path '/' file ];

	set( handles.edit10,'String', file_mat );
	load( file_mat );
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 予測 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fpath
global model

if fpath == 0
	fpath = './';
end

global prm
global prm_fd
global prm_hole
global prm_edge

outpath = uigetdir(fpath);

if outpath == 0
	return;
end

prm_fd.fd.epsilon			= str2num( get(handles.edit3,'String') );
prm_fd.fd.window			= str2num( get(handles.edit4,'String') );

prm.offset.x(1)			= str2num( get(handles.edit5,'String') );
prm.offset.x(2)			= str2num( get(handles.edit6,'String') );
prm.offset.y(1)			= str2num( get(handles.edit7,'String') );
prm.offset.y(2)			= str2num( get(handles.edit8,'String') );

prm_fd.offset = prm.offset;
prm_hole.offset = prm.offset;
prm_edge.offset = prm.offset;


[ result_fd result_hole result_edge class flist ] = get_feature( fpath );

result_all = [ result_fd result_hole result_edge ];

x0 = result_all(:, model.id_select );

x = normalizeData0( x0, model.x_mean, model.x_sd );

N=size(x,1);
X=[ ones(N,1) x ];

Y = X * model.b;
Y_lr = sigmoid( Y );

b_all = zeros( [ size( result_all, 2 ) 1 ] );
for ii=2:length(model.b)
	b_all( model.id_select(ii-1) ) = model.b(ii);
end


csvfile = fullfile(outpath, 'result.csv')
fp = fopen(csvfile,'wt');
fprintf( fp, ',,');
output_header( fp, 'FD', model.prm_fd.edges );
output_header( fp, 'HOLES', model.prm_hole.edges );
output_header( fp, 'EDGES', model.prm_edge.edges );
fprintf( fp, '\n');

fprintf( fp, ',weight,');
for ii=1:length(b_all)
	fprintf(fp,'%f,', b_all(ii) );
end
fprintf( fp, '\n');

fprintf( fp, '\nfilename,Likelihood,\n');
for i1=1:length(flist)
	[filepath,name,ext] = fileparts( flist(i1).filename );
	fprintf(fp,'%s,%f,', name, Y_lr(i1) );
	for i2 = 1:size( result_all,2 )
		fprintf(fp,'%d,', result_all(i1,i2) );
	end
	fprintf( fp, '\n');
end
fclose(fp)



if get( handles.radiobutton1, 'Value') == 1
	%結果を可視化
	rmin = min( Y_lr(:) );
	rmax = max( Y_lr(:) );

	emin = floor(rmin*10)*0.1;
	emax = ceil(rmax*10)*0.1;
	edges = [ emin:0.025:emax ];
	show_result( flist, edges, Y_lr, [ outpath '/sort_images.png' ] );
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function show_result( flist, edges, result, filename );
	nx = length(edges)-1;
	info = [];
	ny = 0;
	for ie = 1:nx

		if ie < nx
			id = find( result >= edges(ie) & result < edges(ie+1) );
		else
			id = find( result >= edges(ie) );
		end
	
		info(ie).id = id;
		
		if ny < length( info(ie).id ); ny = length( info(ie).id ); end
	end
	
	img = imread( flist(1).filename );
	si = size(img);

	nx
	ny
	
	si2 = round( si(1:2)*0.25 );
	yoffset=25;
	sig = [ si2(1)*ny+yoffset si2(2)*nx ]
	
	img_g = uint8( zeros( [ sig 3 ] ) );
	for ie = 1:nx
		xs = (ie-1)*si2(2)+1;
		xe = xs + si2(2) -1;
		img_g = insertText(img_g, [ xs 1 ], num2str(edges(ie)), 'FontSize',18,'BoxColor', 'black', 'TextColor','white' );
		for ii = 1:length(info(ie).id)
			id = info(ie).id(ii);
			ys = yoffset + (ii-1)*si2(1)+1;
			ye = ys + si2(1) -1;

			img = imread( flist(id).filename );
			img_s = imresize( img, si2 );

			img_g(ys:ye,xs:xe,:) = img_s;
		end
	end
	
	figure
	imshow( img_g );
	
	imwrite( img_g, filename );


function output_header( fp, name, edges )
for ii=1:length(edges)-1
	fprintf( fp, '%s [%.1f %.1f),', name, edges(ii), edges(ii+1) )
end

function [ result_fd result_hole result_edge class data ] = get_feature( fpath )

global prm_fd
global prm_hole
global prm_edge

[flist, d] = dir_recursive( fpath );

data = [];
class = [];
for i1 = 1:length( flist )
	[filepath,name,ext] = fileparts(flist(i1).path);
	if strcmp( ext, '.tif') == 1
		data(end+1).filename = flist(i1).path;
		if length( strfind( name, 'A' ) ) > 0
			class(end+1,1) = 1; %Adult
		else
			class(end+1,1) = 0; %Young
		end
	end
end


result_fd = [];
result_hole = [];
result_edge = [];
id_delete = [];
h = waitbar(0,'Please wait...');
n = 0;
for i1 = 1:length( data )
	%try
		img = imread( data(i1).filename );
		[ result_fd(i1,:) img_gray img_gray2 ] = cell_analize( img, prm_fd );
		[ result_hole(i1,:) img_gray img_gray2 ] = cell_analize( img, prm_hole );
		[ result_edge(i1,:) img_gray img_gray2 ] = cell_analize( img, prm_edge );
	%{
	catch
		fprintf( 'cant read %s\n', data(i1).filename );
		id_delete(end+1) = i1;
	end
	%}

	waitbar( i1/length( data )  ,h);
end
close(h);

if length( id_delete ) > 0
	result_fd( id_delete ) = [];
	result_hole( id_delete ) = [];
	result_edge( id_delete ) = [];
	class( id_delete ) = [];
	data( id_delete ) = [];
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
