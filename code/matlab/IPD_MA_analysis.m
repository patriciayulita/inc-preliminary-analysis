%% set working dir and paths

clear;

% Get path of current script
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));

% Confirm
disp(['Working directory set to: ', pwd]);

path_to_input_folder = '../../data';

path_to_output_folder = '../../result';

dataframe_file_oxford = 'dataFrame_oxford.csv';
dataframe_file_exeter = 'dataFrame_exeter.csv';
dataframe_file_ucl = 'dataFrame_ucl.csv';

%% set up

% look if the path to the output folder exist. If not, make it
if ~exist(path_to_output_folder,'dir')
    mkdir(path_to_output_folder)
end

dataframe_ox = readtable(strcat(path_to_input_folder, '/', dataframe_file_oxford));
dataframe_ex = readtable(strcat(path_to_input_folder, '/', dataframe_file_exeter));

% Build the file path
filename = fullfile(path_to_input_folder, dataframe_file_ucl);

% Detect import options
opts = detectImportOptions(filename);

% Force column 'File' to be string
opts = setvartype(opts, 'File', 'string');
dataframe_ucl = readtable(strcat(path_to_input_folder, '/', dataframe_file_ucl),opts);

%% Oxford- validity

% extract all control heel lance data only
% ----------------------------------------
dataframe_ox_cl = dataframe_ox(strcmp(dataframe_ox.Event,'cl'),:);

% save control lance data (single event per participant)
table_name_csv = 'dataframe_ox_controllance.csv';
writetable(dataframe_ox_cl,fullfile(path_to_output_folder,table_name_csv));

% extract all heel lance data only
% --------------------------------
dataframe_ox_hl = dataframe_ox(strcmp(dataframe_ox.Event,'hl'),:);

% save heel lance data (single event per participant)
table_name_csv = 'dataframe_ox_heellance.csv';
writetable(dataframe_ox_hl,fullfile(path_to_output_folder,table_name_csv));

% extract all background data only
% --------------------------------
dataframe_ox_bg = dataframe_ox(strcmp(dataframe_ox.Event,'bg'),:);

% save background data (single event per participant)
table_name_csv = 'dataframe_ox_bg.csv';
writetable(dataframe_ox_bg,fullfile(path_to_output_folder,table_name_csv));

%% Oxford- interpretability

% extract all noxious
% ----------------------------------------
dataframe_ox_nox = dataframe_ox(strcmp(dataframe_ox.Event,'hl') | strcmp(dataframe_ox.Event, 'imm') ...
    | strcmp(dataframe_ox.Event, 'lp') | strcmp(dataframe_ox.Event, 'cn'),:);

% save noxious data
table_name_csv = 'dataframe_ox_nox.csv';
writetable(dataframe_ox_nox,fullfile(path_to_output_folder,table_name_csv));

% extract all innocuous
% ----------------------------------------
dataframe_ox_innoc = dataframe_ox(strcmp(dataframe_ox.Event,'cl') | strcmp(dataframe_ox.Event, 'tf'),:);

% save innocuous data
table_name_csv = 'dataframe_ox_innoc.csv';
writetable(dataframe_ox_innoc,fullfile(path_to_output_folder,table_name_csv));

%% Exeter - validity
 
% extract all control heel lance data only
% ----------------------------------------
dataframe_ex_cl = dataframe_ex(strcmp(dataframe_ex.Event,'cl'),:);

% save control lance data (single event per participant)
table_name_csv = 'dataframe_ex_controllance.csv';
writetable(dataframe_ex_cl,fullfile(path_to_output_folder,table_name_csv));

% extract all heel lance data only
% --------------------------------
dataframe_ex_hl = dataframe_ex(strcmp(dataframe_ex.Event,'hl'),:);

% save heel lance data (single event per participant)
table_name_csv = 'dataframe_ex_heellance.csv';
writetable(dataframe_ex_hl,fullfile(path_to_output_folder,table_name_csv));

% extract all background data only
% --------------------------------
dataframe_ex_bg = dataframe_ex(strcmp(dataframe_ex.Event,'bg'),:);

% save background data (single event per participant)
table_name_csv = 'dataframe_ex_bg.csv';
writetable(dataframe_ex_bg,fullfile(path_to_output_folder,table_name_csv));

%% Exeter - interpretability

% extract all noxious
% ----------------------------------------
% Exeter's nox is only 'hl', so dataframe_ex_nox = dataframe_ex_heellance

% extract all innocuous
% ----------------------------------------
dataframe_ex_innoc = dataframe_ex(strcmp(dataframe_ex.Event,'cl') ...
    | strcmp(dataframe_ex.Event, 'tf'),:);

% save innocuous data
table_name_csv = 'dataframe_ex_innoc.csv';
writetable(dataframe_ex_innoc,fullfile(path_to_output_folder,table_name_csv));

%% UCL - validity
 
% extract all control heel lance data only
% ----------------------------------------
dataframe_ucl_cl = dataframe_ucl(strcmp(dataframe_ucl.Event,'cl'),:);
dataframe_ucl_cl.setname = dataframe_ucl_cl.File;

% save control lance data (single event per participant)
table_name_csv = 'dataframe_ucl_controllance.csv';
writetable(dataframe_ucl_cl,fullfile(path_to_output_folder,table_name_csv));

% extract all heel lance data only
% --------------------------------
dataframe_ucl_hl = dataframe_ucl(strcmp(dataframe_ucl.Event,'hl'),:);

% Remove "_2" only if it appears at the end of a name
dataframe_ucl_hl.setname = regexprep(dataframe_ucl_hl.File, '_2$', '');

% save heel lance data (single event per participant)
table_name_csv = 'dataframe_ucl_heellance.csv';
writetable(dataframe_ucl_hl,fullfile(path_to_output_folder,table_name_csv));

% extract all background data only
% --------------------------------
dataframe_ucl_bg = dataframe_ucl(strcmp(dataframe_ucl.Event,'bg'),:);

% Remove "_2" only if it appears at the end of a name
dataframe_ucl_bg.setname = regexprep(dataframe_ucl_bg.File, '_2$', '');

[uniqueID, ibg] = unique(dataframe_ucl_bg.setname,'first');
dataframe_ucl_bg = dataframe_ucl_bg(ibg,:);

% save background data (single event per participant)
table_name_csv = 'dataframe_ucl_bg.csv';
writetable(dataframe_ucl_bg,fullfile(path_to_output_folder,table_name_csv));

%% UCL - interpretability
% extract all noxious
% ----------------------------------------
% UCL's nox is only 'hl', so dataframe_ucl_nox = dataframe_ucl_heellance

% extract all innocuous
% ----------------------------------------
% UCL's innoc is only 'cl', so dataframe_ucl_innoc = dataframe_ucl_controllance

%% validity: between-sites averaging

% run IPD_MA_stats_2.do (STATA do file) in
% "/Users/patriciagunawan/Library/CloudStorage/OneDrive-Nexus365/Oxford
% S3/EEG/IPD-MA project/code" to create "hl_cl_NRFtable.csv"

% run validity.R (R file) in /Users/patriciagunawan/Library/CloudStorage/OneDrive-Nexus365/Oxford S3/IPD-MA project/Validity

%% interpretability:

% between sites averaging (nox, innoc)
% run interpretability.R from "/Users/patriciagunawan/Library/CloudStorage/OneDrive-Nexus365/Oxford S3/IPD-MA project/Interpretability"

% between sites averaging and then by stimulus types 
% run ipdma.do from
% "/Users/patriciagunawan/Library/CloudStorage/OneDrive-Nexus365/Oxford
% S3/IPD-MA project/Validity" to create "hl_cl_NRFtable_3sites.dta"

% run ipdma_interpretability.do from "/Users/patriciagunawan/Library/CloudStorage/OneDrive-Nexus365/Oxford S3/IPD-MA project/Interpretability" to create "nox_innoc_magdiff_3sites.csv"

% run interpretability_2.R from "/Users/patriciagunawan/Library/CloudStorage/OneDrive-Nexus365/Oxford S3/IPD-MA project/Interpretability"

%% note about creating database

% rename P to Ox52 (manual, replace all P** with Ox52 from
% nox_innoc_magdiff_3sites_PtoOx52_filtered_old), to create
% nox_innoc_magdiff_3sites_PtoOx52_filtered.csv. (IMPORTANT: participants
% could appear repeatedly, check all P**)

% ipdma_database_step2.do and ipdma_database_step2_2.do are both ok. But just run
% ipdma_database_step2. I created ipdma_database_step2_2 just for
% sensitivity test for interpretability dataset (the outcome dataset will be different 
% in number of columns between those two .do).

%% demographics of database
% code in STATA (demographics_code) and demographics_code_allevents.
% demographics_code is individual (unique) participant, while
% demographics_code_allevents is all epochs analysed (could be more than 1
% epoch per participant if they received more than 1 stim type)

%% effect size

% run interpretability_2.R (the code underneath the typical magnitude
% calculation)
