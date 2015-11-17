function newfcn(fcnname)
% NEWFCN create a MATLAB function with entered filename
%
%   NEWFCN creates a M-File having the entered filename and a specific
%   structure which helps for creating the main function structure. It
%   would be opened and the starting line for writting will be highlighted
%   (Only available in R14 or higher). The actual working MATLAB Version
%   will be also captured. If user forgot to enter code and execute the
%   function, he will get a reminder to enter code in the function.
%
%   NEWFCN, NEWSL, NEWXPC and NEWFCN_RENAME are a set of M-Functions which
%   shold help the MATLAB User to create Functions, Simulink and xPC Target
%   based Models in a quick Way.
% 
%   These Files are shared for all Users in :
%   http://www.mathworks.com/matlabcentral/fileexchange Syntax :  
%   >> newfcn M_FcnName  or  >> newfcn('M_FcnName')
%
%   Example :
%   ---------
%   >> newfcn dummy
%
%   %%%%%%%%%% BEGINN CODE %%%%%%%%%%
%      function dummy()
%      % DUMMY ... 
%      %  
%      %   ... 
%      
%      %% AUTHOR    : Frank Gonzalez-Morphy 
%      %% $DATE     : 15-Jul-2004 15:36:42 $ 
%      %% $Revision : 1.00 $ 
%      %% DEVELOPED : 7.0.0.19920 (R14)
%      %% FILENAME  : dummy.m 
%      
%      disp(' !!!  You must enter code into this file < dummy.m > !!!') 
%      
%      % Created with NEWFCN.m by Frank González-Morphy  
%      % ... mailto: frank.gonzalez-morphy@mathworks.de  
%      % ===== EOF ====== [dummy.m] ======  
%      
%   %%%%%%%%%% CODE - END  %%%%%%%%%%
%
%   See also: NEWFCN_RENAME NEWSL NEWXPC 

%% AUTHOR    : Frank Gonzalez-Morphy 
%% $DATE     : 18-Dec-2001 16:46:44 $ 
%% $Revision : 1.30 $ 
%% FILENAME  : newfcn.m 

%% MODIFICATIONS:
%% $26-Sep-2002 14:44:35 $
%% Developent point added, to be know, under which version of
%% MATLAB the new Fcn generated was [Line:80]
%% ---
%% $25-Feb-2002 07:29:17 $ 
%% change BREAK to RETURN after Warning message of R13B2: 
%% "A BREAK statement appeared outside of a loop.  This BREAK ..."
%% "is interpreted as a RETURN."
%% ----
%% $17-Jun-2004 15:12:55 $ 
%% Add version checking for R14 and accessing OPENTOLINE from codepad
%% See Lines from 103 till 109
%% changed Line 77 to 'version'
%% ----
%% $15-Jul-2004 15:20:50 $
%% Add Originlines and wrote comments for release it at MATLABcentral.
%% 

if nargin == 0, help(mfilename); return; end
if nargin > 1, error('  MSG: Only one Parameter accepted!'); end


ex = exist(fcnname);  % does M-Function already exist ? Loop statement
while ex == 2         % rechecking existence
    overwrite = 0;    % Creation decision
    msg = sprintf(['Sorry, but Function -< %s.m >- does already exist!\n', ...
        'Do you wish to Overwrite it ?'], fcnname);
    % Action Question: Text, Title, Buttons and last one is the Default
    action = questdlg(msg, ' Overwrite Function?', 'Yes', 'No','No');
    if strcmp(action,'Yes') == 1
        ex = 0; % go out of While Loop, set breaking loop statement
    else
        % Dialog for new Functionname
        fcnname = char(inputdlg('Enter new Function Name ... ', 'NEWFCN - New Name'));
        if isempty(fcnname) == 1  % {} = Cancel Button => "1"
            disp('   MSG: User decided to Cancel !')
            return
        else
            ex = exist(fcnname);  % does new functionname exist ?
        end
    end
end

overwrite = 1;

if overwrite == 1
    CreationMsg = CreateFcn(fcnname);   % Call of Sub-Function
    disp(['   MSG: <' fcnname '.m> ' CreationMsg])
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%   CREATEFCN   %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function s = CreateFcn(name)
% Sub-Function will write the M-File, open it and mark the starting write
% line

ext = '.m';  % Default extension for a FUNCTION !!
filename = [name ext];

fid = fopen(filename,'w');

line_1 = ['function ',name,'()']; % Function Header

str_tmp1 = upper(name);
h1 = ['% ', str_tmp1, ' ...'];    % HELP-Line's will be preset
h2 = '% ';
h3 = '%   ...';

fprintf(fid,'%s\n', line_1);      % First 4 Lines will be write in file
fprintf(fid,'%s \n', h1);         %   "
fprintf(fid,'%s \n', h2);         %   "
fprintf(fid,'%s \n\n', h3);       %   "

% Writer settings will be consructed ...
author = '%$ Author: Jose Marcos Rodriguez $';
dt = datestr(now);                
date = ['%$ Date: ', dt, ' $'];
rev = ['%$ Revision : 1.00 $'];
filenamesaved = filename;         fns = ['%% FILENAME  : ', filenamesaved];

% Line 5-10 will be write in File ...
fprintf(fid,'%s \n', author);
fprintf(fid,'%s \n', date);
fprintf(fid,'%s \n', rev);
fprintf(fid,'%s \n\n', fns);

% Reminder that user must enter code in created File / Function
lst = 'disp('' !!!  You must enter code into this file <';
lst_3 = '> !!!'')';
fprintf(fid,'%s %s.m %s \n', lst, name, lst_3);
    
% Close the written File
st = fclose(fid);

if st == 0  % "0" for successful
    % Open the written File in the MATLAB Editor/Debugger
    v = version;
    if v(1) == '7'                 % R14 Version
        opentoline(filename, 12);  % Open File and highlight the start Line
    else
        % ... for another versions of MATLAB
        edit(filename);
    end
    s = 'successfully done !!';
else
    s = ' ERROR: Problems encounter while closing File!';
end

% ===== EOF ===== [newfcn.m] ======
