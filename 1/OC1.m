function varargout = OC1(varargin)
% OC1 MATLAB code for OC1.fig
%      OC1, by itself, creates a new OC1 or raises the existing
%      singleton*.
%
%      H = OC1 returns the handle to a new OC1 or the handle to
%      the existing singleton*.
%
%      OC1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OC1.M with the given input arguments.
%
%      OC1('Property','Value',...) creates a new OC1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OC1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OC1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OC1

% Last Modified by GUIDE v2.5 11-Mar-2014 12:03:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OC1_OpeningFcn, ...
                   'gui_OutputFcn',  @OC1_OutputFcn, ...
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


% --- Executes just before OC1 is made visible.
function OC1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OC1 (see VARARGIN)

% Choose default command line output for OC1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OC1 wait for user response (see UIRESUME)
% uiwait(handles.main_figure);

global sol solved X0 X1 phi1 phi2 solver Tmax Npoints time_stemp EPS show_other_trajectories;

solved = 0;
phi1 = 0;
phi2 = 2 * pi;

show_other_trajectories = 1;

axes(handles.x_axes);
xlabel('x_1');
ylabel('x_2');
axes(handles.x1_axes);
xlabel('t');
ylabel('x_1');
axes(handles.x2_axes);
xlabel('t');
ylabel('x_2');
axes(handles.u1_axes);
xlabel('t');
ylabel('u_1');
axes(handles.u2_axes);
xlabel('t');
ylabel('u_2');
axes(handles.phi1_axes);
xlabel('t');
ylabel('\phi_1');
axes(handles.phi2_axes);
xlabel('t');
ylabel('\phi_2');
axes(handles.u_axes);
xlabel('u_1');
ylabel('u_2');

% --- Outputs from this function are returned to the command line.
function varargout = OC1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function A11_Callback(hObject, eventdata, handles)
% hObject    handle to A11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A11 as text
%        str2double(get(hObject,'String')) returns contents of A11 as a double


% --- Executes during object creation, after setting all properties.
function A11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A12_Callback(hObject, eventdata, handles)
% hObject    handle to A12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A12 as text
%        str2double(get(hObject,'String')) returns contents of A12 as a double


% --- Executes during object creation, after setting all properties.
function A12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A21_Callback(hObject, eventdata, handles)
% hObject    handle to A21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A21 as text
%        str2double(get(hObject,'String')) returns contents of A21 as a double


% --- Executes during object creation, after setting all properties.
function A21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A22_Callback(hObject, eventdata, handles)
% hObject    handle to A22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A22 as text
%        str2double(get(hObject,'String')) returns contents of A22 as a double


% --- Executes during object creation, after setting all properties.
function A22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B11_Callback(hObject, eventdata, handles)
% hObject    handle to B11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B11 as text
%        str2double(get(hObject,'String')) returns contents of B11 as a double


% --- Executes during object creation, after setting all properties.
function B11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B12_Callback(hObject, eventdata, handles)
% hObject    handle to B12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B12 as text
%        str2double(get(hObject,'String')) returns contents of B12 as a double


% --- Executes during object creation, after setting all properties.
function B12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B21_Callback(hObject, eventdata, handles)
% hObject    handle to B21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B21 as text
%        str2double(get(hObject,'String')) returns contents of B21 as a double


% --- Executes during object creation, after setting all properties.
function B21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B22_Callback(hObject, eventdata, handles)
% hObject    handle to B22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B22 as text
%        str2double(get(hObject,'String')) returns contents of B22 as a double


% --- Executes during object creation, after setting all properties.
function B22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q11_Callback(hObject, eventdata, handles)
% hObject    handle to Q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q11 as text
%        str2double(get(hObject,'String')) returns contents of Q11 as a double


% --- Executes during object creation, after setting all properties.
function Q11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q12_Callback(hObject, eventdata, handles)
% hObject    handle to Q12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q12 as text
%        str2double(get(hObject,'String')) returns contents of Q12 as a double


% --- Executes during object creation, after setting all properties.
function Q12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q21_Callback(hObject, eventdata, handles)
% hObject    handle to Q21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q21 as text
%        str2double(get(hObject,'String')) returns contents of Q21 as a double


% --- Executes during object creation, after setting all properties.
function Q21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q22_Callback(hObject, eventdata, handles)
% hObject    handle to Q22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q22 as text
%        str2double(get(hObject,'String')) returns contents of Q22 as a double


% --- Executes during object creation, after setting all properties.
function Q22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to p1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p1_edit as text
%        str2double(get(hObject,'String')) returns contents of p1_edit as a double


% --- Executes during object creation, after setting all properties.
function p1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to p2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2_edit as text
%        str2double(get(hObject,'String')) returns contents of p2_edit as a double


% --- Executes during object creation, after setting all properties.
function p2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_edit_Callback(hObject, eventdata, handles)
% hObject    handle to a_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_edit as text
%        str2double(get(hObject,'String')) returns contents of a_edit as a double


% --- Executes during object creation, after setting all properties.
function a_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t0_edit_Callback(hObject, eventdata, handles)
% hObject    handle to t0_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t0_edit as text
%        str2double(get(hObject,'String')) returns contents of t0_edit as a double


% --- Executes during object creation, after setting all properties.
function t0_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t0_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alpha1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to alpha1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha1_edit as text
%        str2double(get(hObject,'String')) returns contents of alpha1_edit as a double


% --- Executes during object creation, after setting all properties.
function alpha1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alpha2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha2_edit as text
%        str2double(get(hObject,'String')) returns contents of alpha2_edit as a double


% --- Executes during object creation, after setting all properties.
function alpha2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function draw_in_x_axes()
	global X0 X1 sol show_other_trajectories;
	cla();
	hold on;
	STEP = 1e-2;
	[x, y] = X0.get_border(STEP);
	plot(x, y, 'g');
	[x, y] = X1.get_border(STEP);
	plot(x, y, 'r');
	legend('X_0', 'X_1');
	if show_other_trajectories == 1
		for i = 1 : size(sol.X1, 2)
			plot(sol.X1(1 : sol.X_last_num(i), i), sol.X2(1 : sol.X_last_num(i), i));
		end
	end
	if sol.U_min_num ~= -1
		i = sol.U_min_num;
		t = sol.X_last_num(i);
		plot(sol.X1(1 : t, i), sol.X2(1 : t, i), 'r');
		quiver(sol.X1(t, i), sol.X2(t, i), sol.NeedPhi(1), sol.NeedPhi(2), 'g');
		quiver(sol.X1(t, i), sol.X2(t, i), sol.GotPhi(1), sol.GotPhi(2), 'r');
	end
	xlabel('x_1');
	ylabel('x_2');

	
function draw_in_u_axes()
	global sol P show_other_trajectories;
	cla();
	hold on;
	if show_other_trajectories == 1
		STEP = 1e-2;
		[x, y] = P.get_border(STEP);
		plot(x, y);
	end
	if sol.U_min_num ~= -1
		i = sol.U_min_num;
		t = sol.X_last_num(i);
		plot(sol.U1(1 : t, i), sol.U2(1 : t, i), 'r');
	end
	xlabel('u_1');
	ylabel('u_2');
	
	
function draw_in_phi1_axes()
	global sol show_other_trajectories;
	cla();
	hold on;
	if show_other_trajectories == 1
		for i = 1 : size(sol.Phi1, 2)
			plot(sol.T, sol.Phi1(:, i));
		end
	end
	if sol.U_min_num ~= -1
		i = sol.U_min_num;
		t = sol.X_last_num(i);
		i = sol.U_phi_num(i);
		plot(sol.T(1 : t), sol.Phi1(1 : t, i), 'r');
	end
	xlabel('t');
	ylabel('phi_1');


function draw_in_phi2_axes()
	global sol show_other_trajectories;
	cla();
	hold on;
	if show_other_trajectories == 1
		for i = 1 : size(sol.Phi2, 2)
			plot(sol.T, sol.Phi2(:, i));
		end
	end
	if sol.U_min_num ~= -1
		i = sol.U_min_num;
		t = sol.X_last_num(i);
		i = sol.U_phi_num(i);
		plot(sol.T(1 : t), sol.Phi2(1 : t, i), 'r');
	end
	xlabel('t');
	ylabel('phi_2');
	

function draw_in_u1_axes()
	global sol show_other_trajectories;
	cla();
	hold on;
	if show_other_trajectories == 1
		for i = 1 : size(sol.U1, 2)
			plot(sol.T, sol.U1(:, i));
		end
	end
	if sol.U_min_num ~= -1
		i = sol.U_min_num;
		t = sol.X_last_num(i);
		plot(sol.T(1 : t), sol.U1(1 : t, i), 'r');
	end
	xlabel('t');
	ylabel('u_1');
	
	
function draw_in_u2_axes()
	global sol show_other_trajectories;
	cla();
	hold on;
	if show_other_trajectories == 1
		for i = 1 : size(sol.U2, 2)
			plot(sol.T, sol.U2(:, i));
		end
	end
	if sol.U_min_num ~= -1
		i = sol.U_min_num;
		t = sol.X_last_num(i);
		plot(sol.T(1 : t), sol.U2(1 : t, i), 'r');
	end
	xlabel('t');
	ylabel('u_2');
	

function draw_in_x1_axes()
	global sol show_other_trajectories;
	cla();
	hold on;
	if show_other_trajectories == 1
		for i = 1 : size(sol.X1, 2)
			plot(sol.T, sol.X1(:, i));
		end
	end
	if sol.U_min_num ~= -1
		i = sol.U_min_num;
		t = sol.X_last_num(i);
		plot(sol.T(1 : t), sol.X1(1 : t, i), 'r');
	end
	xlabel('t');
	ylabel('x_1');
		
	
function draw_in_x2_axes()
	global sol show_other_trajectories;
	cla();
	hold on;
	if show_other_trajectories == 1
		for i = 1 : size(sol.X2, 2)
			plot(sol.T, sol.X2(:, i));
		end
	end
	if sol.U_min_num ~= -1
		i = sol.U_min_num;
		t = sol.X_last_num(i);
		plot(sol.T(1 : t), sol.X2(1 : t, i), 'r');
	end
	xlabel('t');
	ylabel('x_2');

	
function draw_all(handles)
	global sol;

	axes(handles.x_axes);
	draw_in_x_axes();
	
	axes(handles.u_axes);
	draw_in_u_axes();
	
	axes(handles.phi1_axes);
	draw_in_phi1_axes();

	axes(handles.phi2_axes);
	draw_in_phi2_axes();

	axes(handles.u1_axes);
	draw_in_u1_axes();

	axes(handles.u2_axes);
	draw_in_u2_axes();
	
	axes(handles.x1_axes);
	draw_in_x1_axes();

	axes(handles.x2_axes);
	draw_in_x2_axes();
	
	if sol.Solvability == 1
		set(handles.solvability_text, 'String', 'Problem was solved');
		set(handles.t_res_res_text, 'String', num2str(sol.Tmin));
		set(handles.terror_res_text, 'String', num2str(sol.TransversalityError));
		set(handles.angle_cos_res_text, 'String', num2str(sol.EndAngleCos));
	else
		set(handles.solvability_text, 'String', 'Problem wasn''t solved. Try to increase Tmax or EPSs.');
		set(handles.t_res_res_text, 'String', 'N/A');
		set(handles.terror_res_text, 'String', 'N/A');
		set(handles.angle_cos_res_text, 'String', 'N/A');
	end

	
% --- Executes on button press in solve_button.
function solve_button_Callback(hObject, eventdata, handles)
% hObject    handle to solve_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global solved sol X0 X1 P solver Npoints Tmax time_stemp EPS;

	A = strcat('[', get(handles.A11, 'String'), ',', get(handles.A12, 'String'), ';', get(handles.A21, 'String'), ',', get(handles.A22, 'String'), ']');
	B = strcat('[', get(handles.B11, 'String'), ',', get(handles.B12, 'String'), ';', get(handles.B21, 'String'), ',', get(handles.B22, 'String'), ']');
	Q = strcat('[', get(handles.Q11, 'String'), ',', get(handles.Q12, 'String'), ';', get(handles.Q21, 'String'), ',', get(handles.Q22, 'String'), ']');
	t0 = str2double(get(handles.t0_edit, 'String'));
	p = [str2double(get(handles.p1_edit, 'String')); str2double(get(handles.p2_edit, 'String'))];
	a = str2double(get(handles.a_edit, 'String'));
	alpha1 = str2double(get(handles.alpha1_edit, 'String'));
	alpha2 = str2double(get(handles.alpha2_edit, 'String'));
	Tmax = str2double(get(handles.Tmax_edit, 'String'));
	Npoints = str2double(get(handles.Npoints_edit, 'String'));
	time_stemp = str2double(get(handles.time_stemp_edit, 'String'));
	touching_x1 = str2double(get(handles.touching_x1_edit, 'String'));
	specific_mode = str2double(get(handles.specific_mode_edit, 'String'));
	zero_in_imag_testing = str2double(get(handles.zero_in_imag_testing_edit, 'String'));
	rel_tol = str2double(get(handles.rel_tol_edit, 'String'));
	abs_tol = [str2double(get(handles.abs_tol1_edit, 'String')) str2double(get(handles.abs_tol2_edit, 'String'))];
	b_deviation = 1e-6;
	
	X0 = X0Class(alpha1, alpha2);
	X1 = X1Class(a);
	P = PClass(Q, p);

	%EPS = EPSClass(1e-7, 1e-6, 1e-9, 1e-4, [1e-4 1e-4]);
	EPS = EPSClass(touching_x1, specific_mode, zero_in_imag_testing, rel_tol, abs_tol, b_deviation);
	
	solver = ProblemSolver(A, B, t0, Q, p, a, alpha1, alpha2, X0, X1, P, Npoints, Tmax, time_stemp);
	sol = solver.solve();
	solved = 1;
	
	draw_all(handles);
	
	
% --- Executes on button press in example_button.
function example_button_Callback(hObject, eventdata, handles)
% hObject    handle to example_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	set(handles.A11, 'String', 'sin(t)');
	set(handles.A12, 'String', '0');	
	set(handles.A21, 'String', '1');
	set(handles.A22, 'String', 'cos(t)');

	set(handles.B11, 'String', 'sin(t)^2');
	set(handles.B12, 'String', 'sin(t^2)');	
	set(handles.B21, 'String', '1');
	set(handles.B22, 'String', '2');

	set(handles.Q11, 'String', '3');
	set(handles.Q12, 'String', '4');	
	set(handles.Q21, 'String', '4');
	set(handles.Q22, 'String', '6');
	
	set(handles.t0_edit, 'String', '0');

	set(handles.p1_edit, 'String', '1');
	set(handles.p2_edit, 'String', '-1');

	set(handles.a_edit, 'String', '3');

	set(handles.alpha1_edit, 'String', '2');
	set(handles.alpha2_edit, 'String', '5');
	
	set(handles.Tmax_edit, 'String', '1');
	set(handles.Npoints_edit, 'String', '60');
	set(handles.time_stemp_edit, 'String', '1e-2');
	
	set(handles.touching_x1_edit, 'String', '1e-7');
	set(handles.specific_mode_edit, 'String', '1e-6');
	set(handles.zero_in_imag_testing_edit, 'String', '1e-9');
	set(handles.rel_tol_edit, 'String', '1e-4');
	set(handles.abs_tol1_edit, 'String', '1e-4');
	set(handles.abs_tol2_edit, 'String', '1e-4');


% --- Executes on mouse press over axes background.
function x_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to x_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global solved;
	if solved > 0
		fig = figure;
		draw_in_x_axes();
	end


% --- Executes on mouse press over axes background.
function u_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to u_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global solved;
	if solved > 0
		fig = figure;
		draw_in_u_axes();
	end


% --- Executes on mouse press over axes background.
function x1_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to x1_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global solved;
	if solved > 0
		fig = figure;
		draw_in_x1_axes();
	end


% --- Executes on mouse press over axes background.
function x2_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to x2_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global solved;
	if solved > 0
		fig = figure;
		draw_in_x2_axes();
	end


% --- Executes on mouse press over axes background.
function phi1_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to phi1_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global solved;
	if solved > 0
		fig = figure;
		draw_in_phi1_axes();
	end


% --- Executes on mouse press over axes background.
function phi2_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to phi2_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global solved;
	if solved > 0
		fig = figure;
		draw_in_phi2_axes();
	end


% --- Executes on mouse press over axes background.
function u1_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to u1_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global solved;
	if solved > 0
		fig = figure;
		draw_in_u1_axes();
	end


% --- Executes on mouse press over axes background.
function u2_axes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to u2_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global solved;
	if solved > 0
		fig = figure;
		draw_in_u2_axes();
	end



function Tmax_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Tmax_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tmax_text as text
%        str2double(get(hObject,'String')) returns contents of Tmax_text as a double


% --- Executes during object creation, after setting all properties.
function Tmax_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tmax_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Tmax_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Npoints_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Npoints_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Npoints_edit as text
%        str2double(get(hObject,'String')) returns contents of Npoints_edit as a double


% --- Executes during object creation, after setting all properties.
function Npoints_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Npoints_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_stemp_edit_Callback(hObject, eventdata, handles)
% hObject    handle to time_stemp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_stemp_edit as text
%        str2double(get(hObject,'String')) returns contents of time_stemp_edit as a double


% --- Executes during object creation, after setting all properties.
function time_stemp_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_stemp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clarify_button.
function clarify_button_Callback(hObject, eventdata, handles)
% hObject    handle to clarify_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global sol solver;
	sol = solver.clarify(sol);
	draw_all(handles);



function touching_x1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to touching_x1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of touching_x1_edit as text
%        str2double(get(hObject,'String')) returns contents of touching_x1_edit as a double


% --- Executes during object creation, after setting all properties.
function touching_x1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to touching_x1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function specific_mode_edit_Callback(hObject, eventdata, handles)
% hObject    handle to specific_mode_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of specific_mode_edit as text
%        str2double(get(hObject,'String')) returns contents of specific_mode_edit as a double


% --- Executes during object creation, after setting all properties.
function specific_mode_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to specific_mode_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zero_in_imag_testing_edit_Callback(hObject, eventdata, handles)
% hObject    handle to zero_in_imag_testing_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zero_in_imag_testing_edit as text
%        str2double(get(hObject,'String')) returns contents of zero_in_imag_testing_edit as a double


% --- Executes during object creation, after setting all properties.
function zero_in_imag_testing_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zero_in_imag_testing_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rel_tol_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rel_tol_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rel_tol_edit as text
%        str2double(get(hObject,'String')) returns contents of rel_tol_edit as a double


% --- Executes during object creation, after setting all properties.
function rel_tol_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rel_tol_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function abs_tol1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to abs_tol1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of abs_tol1_edit as text
%        str2double(get(hObject,'String')) returns contents of abs_tol1_edit as a double


% --- Executes during object creation, after setting all properties.
function abs_tol1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to abs_tol1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function abs_tol2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to abs_tol2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of abs_tol2_edit as text
%        str2double(get(hObject,'String')) returns contents of abs_tol2_edit as a double


% --- Executes during object creation, after setting all properties.
function abs_tol2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to abs_tol2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in showhide_checkbox.
function showhide_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to showhide_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showhide_checkbox
	global show_other_trajectories;
	show_other_trajectories = get(handles.showhide_checkbox, 'Value');
	draw_all(handles);
