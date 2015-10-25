function varargout = GUiTest(varargin)
% GUITEST MATLAB code for GUiTest.fig
%      GUITEST, by itself, creates a new GUITEST or raises the existing
%      singleton*.
%
%      H = GUITEST returns the handle to a new GUITEST or the handle to
%      the existing singleton*.
%
%      GUITEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITEST.M with the given input arguments.
%
%      GUITEST('Property','Value',...) creates a new GUITEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUiTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUiTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUiTest

% Last Modified by GUIDE v2.5 15-Feb-2015 17:02:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUiTest_OpeningFcn, ...
                   'gui_OutputFcn',  @GUiTest_OutputFcn, ...
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


% --- Executes just before GUiTest is made visible.
function GUiTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUiTest (see VARARGIN)

% Choose default command line output for GUiTest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% get G from workspace
G = evalin('base', 'G');
setappdata(handles.uitable1, 'G', G);

% get U from workspace
U = evalin('base', 'U');
ocene = num2cell(ones(length(U), 1));
U = [U ocene];
ocene = cell2mat(U(:, 2));

[Rgz, Rj] = racunajPageRank(G, ocene);
Rgz = num2cell(Rgz);
Rj = num2cell(Rj);
U = [U Rgz Rj];
setappdata(handles.uitable1, 'U', U); % setting U as appdata so it can be used in a callback fnc

% sorts U by third column from highest value to lowest
U = sortrows(U, -3);
set(handles.uitable1, 'data', U);

% UIWAIT makes GUiTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUiTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
    % get U and G from appdata
    U = getappdata(hObject, 'U');
    G = getappdata(hObject, 'G');
    
    % convert data from table to numeric
    insertData = str2double(eventdata.EditData);
    if(insertData > 0 & insertData <= 5)
        UfromTable = get(handles.uitable1, 'data');
        URL = UfromTable{eventdata.Indices(1, 1), 1}
        
        [rows, cols] = find(strcmp(URL, U));
        U{rows, cols + 1} = insertData;
        
        ocene = cell2mat(U(:, 2));
        [Rgz, Rj] = racunajPageRank(G, ocene);
        Rgz = num2cell(Rgz);
        Rj = num2cell(Rj);
        U = [U(:, 1) U(:, 2) Rgz Rj];
        setappdata(handles.uitable1, 'U', U);
        
        U = sortrows(U, -3);
        set(handles.uitable1, 'data', U);
    else
        disp('Fail');
    end;
    
