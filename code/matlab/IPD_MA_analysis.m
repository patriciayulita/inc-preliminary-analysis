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
dataframe_ucl = readtable(strcat(path_to_input_folder, '/', dataframe_file_ucl));

%% Oxford- validity

% extract all control heel lance data only
% ----------------------------------------
grouptable_cl = grouptable(strcmp(grouptable.Event,'cl'),:);

% save control lance data (single event per participant)
table_name_csv = 'grouptable_controllance.csv';
writetable(grouptable_cl,fullfile(path_to_output_folder,table_name_csv));

% extract all heel lance data only
% --------------------------------
grouptable_hl = grouptable(strcmp(grouptable.Event,'hl'),:);

% save heel lance data (single event per participant)
table_name_csv = 'grouptable_heellance.csv';
writetable(grouptable_hl,fullfile(path_to_output_folder,table_name_csv));

% extract all background data only
% --------------------------------
grouptable_bg = grouptable(strcmp(grouptable.Event,'bg'),:);

% save background data (single event per participant)
table_name_csv = 'grouptable_bg.csv';
writetable(grouptable_bg,fullfile(path_to_output_folder,table_name_csv));

%% Oxford- interpretability

% extract all noxious
% ----------------------------------------
grouptable_nox = grouptable(strcmp(grouptable.Event,'hl') | strcmp(grouptable.Event, 'imm') ...
    | strcmp(grouptable.Event, 'lp') | strcmp(grouptable.Event, 'cn'),:);

% save noxious data
table_name_csv = 'grouptable_nox.csv';
table_name = 'grouptable_nox';
destinationFolder1 = "/Volumes/Extreme SSD/IPD-MA project/result/Oxford_data_analysis/";

writetable(grouptable_nox,fullfile(destinationFolder1,table_name_csv));
save(fullfile(destinationFolder1,table_name),'grouptable_nox');

destinationFolder2 = "/Users/patriciagunawan/Library/CloudStorage/OneDrive-Nexus365/Oxford S3/IPD-MA project/Validity/Oxford_data_analysis/";

writetable(grouptable_nox,fullfile(destinationFolder2,table_name_csv));

% extract all innocuous
% ----------------------------------------
grouptable_innoc = grouptable(strcmp(grouptable.Event,'cl') | strcmp(grouptable.Event, 'tf'),:);

% save innocuous data
table_name_csv = 'grouptable_innoc.csv';
table_name = 'grouptable_innoc';
destinationFolder1 = "/Volumes/Extreme SSD/IPD-MA project/result/Oxford_data_analysis/";

writetable(grouptable_innoc,fullfile(destinationFolder1,table_name_csv));
save(fullfile(destinationFolder1,table_name),'grouptable_innoc');

destinationFolder2 = "/Users/patriciagunawan/Library/CloudStorage/OneDrive-Nexus365/Oxford S3/IPD-MA project/Validity/Oxford_data_analysis/";

writetable(grouptable_innoc,fullfile(destinationFolder2,table_name_csv));

%% Exeter

destinationFolder = '/Volumes/Extreme SSD/IPD-MA project/result/'; % Patricia OS Mac (lab PC)

% Load EEG
ALLEEG = loadToALLEEGStruct(id_ex, destinationFolder, 'all');

% Stack data, NRF and QC features
NRFtable = table_from_NRF(ALLEEG, 'noxious_NRF_500Hz'); % table of NRF values
datatable = table_from_data(ALLEEG,[]); % table with raw data
% table_qc = table_from_qc(ALLEEG, {'CZ'}); % table with qc features
% [~, table_qc] = InteractiveQCRaincloud(table_qc, 'zscored'); % get z-scores for qc features

% Merge individual tables
grouptable = join(NRFtable, datatable);
% grouptable = join(grouptable, table_qc);

% Note: if you wanted to remove epochs with qc feature 1 |z| > 3,
% you would run:
% grouptable(grouptable.zscores(:,1) > 3, :) = []; 

grouptable_ex = grouptable(:,1:5);

% save grouptable_save
table_name_csv = 'dataframe_exeter.csv';
table_name = 'dataframe_exeter';

writetable(grouptable_ex,fullfile(destinationFolder,table_name_csv));
save(fullfile(destinationFolder,table_name),'grouptable_ex');

%% Exeter - validity
 
% extract all control heel lance data only
% ----------------------------------------
grouptable_cl = grouptable(strcmp(grouptable.Event,'cl'),:);

% save control lance data (single event per participant)
table_name_csv = 'grouptable_controllance.csv';
table_name = 'grouptable_controllance';
destinationFolder = "/Volumes/Extreme SSD/IPD-MA project/result/Exeter_data_analysis/";

writetable(grouptable_cl,fullfile(destinationFolder,table_name_csv));
save(fullfile(destinationFolder,table_name),'grouptable_cl');

% extract all heel lance data only
% --------------------------------
grouptable_hl = grouptable(strcmp(grouptable.Event,'hl'),:);

% save heel lance data (single event per participant)
table_name_csv = 'grouptable_heellance.csv';
table_name = 'grouptable_heellance';

writetable(grouptable_hl,fullfile(destinationFolder,table_name_csv));
save(fullfile(destinationFolder,table_name),'grouptable_hl');

% extract all background data only
% --------------------------------
grouptable_bg = grouptable(strcmp(grouptable.Event,'bg'),:);

% save background data (single event per participant)
table_name_csv = 'grouptable_bg.csv';
table_name = 'grouptable_bg';

writetable(grouptable_bg,fullfile(destinationFolder,table_name_csv));
save(fullfile(destinationFolder,table_name),'grouptable_bg');

%% Exeter - interpretability

% extract all noxious
% ----------------------------------------
% Exeter's nox is only 'hl', so grouptable_nox = grouptable_heellance

% extract all innocuous
% ----------------------------------------
grouptable_innoc = grouptable(strcmp(grouptable.Event,'cl') ...
    | strcmp(grouptable.Event, 'tf'),:);

% save innocuous data
table_name_csv = 'grouptable_innoc.csv';
table_name = 'grouptable_innoc';
destinationFolder = "/Volumes/Extreme SSD/IPD-MA project/result/Exeter_data_analysis/";

writetable(grouptable_innoc,fullfile(destinationFolder,table_name_csv));
save(fullfile(destinationFolder,table_name),'grouptable_innoc');

%% UCL

destinationFolder = '/Volumes/Extreme SSD/IPD-MA project/result/UCL_data'; % Patricia OS Mac (lab PC)

% Load EEG
ALLEEG = loadToALLEEGStruct(id_ucl, destinationFolder, 'all','*');

% Stack data, NRF and QC features
NRFtable = table_from_NRF(ALLEEG, 'noxious_NRF_500Hz'); % table of NRF values
datatable = table_from_data(ALLEEG,[]); % table with raw data
% table_qc = table_from_qc(ALLEEG, {'CZ'}); % table with qc features
% [~, table_qc] = InteractiveQCRaincloud(table_qc, 'zscored'); % get z-scores for qc features

% Merge individual tables
grouptable = join(NRFtable, datatable);
% grouptable = join(grouptable, table_qc);

% Note: if you wanted to remove epochs with qc feature 1 |z| > 3,
% you would run:
% grouptable(grouptable.zscores(:,1) > 3, :) = []; 

grouptable_ucl = grouptable(:,1:5);

% save grouptable_save
table_name_csv = 'dataframe_ucl.csv';
table_name = 'dataframe_ucl';

writetable(grouptable_ucl,fullfile(destinationFolder,table_name_csv));
save(fullfile(destinationFolder,table_name),'grouptable_ucl');

%% UCL - validity
 
% extract all control heel lance data only
% ----------------------------------------
grouptable_cl = grouptable(strcmp(grouptable.Event,'cl'),:);
grouptable_cl.setname = grouptable_cl.File;

% save control lance data (single event per participant)
table_name_csv = 'grouptable_controllance.csv';
table_name = 'grouptable_controllance';
destinationFolder = "/Volumes/Extreme SSD/IPD-MA project/result/UCL_data_analysis/";

writetable(grouptable_cl,fullfile(destinationFolder,table_name_csv));
save(fullfile(destinationFolder,table_name),'grouptable_cl');

% extract all heel lance data only
% --------------------------------
grouptable_hl = grouptable(strcmp(grouptable.Event,'hl'),:);

% Remove "_2" only if it appears at the end of a name
grouptable_hl.setname = regexprep(grouptable_hl.File, '_2$', '');

% save heel lance data (single event per participant)
table_name_csv = 'grouptable_heellance.csv';
table_name = 'grouptable_heellance';

writetable(grouptable_hl,fullfile(destinationFolder,table_name_csv));
save(fullfile(destinationFolder,table_name),'grouptable_hl');

% extract all background data only
% --------------------------------
grouptable_bg = grouptable(strcmp(grouptable.Event,'bg'),:);

% Remove "_2" only if it appears at the end of a name
grouptable_bg.setname = regexprep(grouptable_bg.File, '_2$', '');

[uniqueID, ibg] = unique(grouptable_bg.setname,'first');
grouptable_bg = grouptable_bg(ibg,:);

% save background data (single event per participant)
table_name_csv = 'grouptable_bg.csv';
table_name = 'grouptable_bg';

writetable(grouptable_bg,fullfile(destinationFolder,table_name_csv));
save(fullfile(destinationFolder,table_name),'grouptable_bg');

%% UCL - interpretability
% extract all noxious
% ----------------------------------------
% UCL's nox is only 'hl', so grouptable_nox = grouptable_heellance

% extract all innocuous
% ----------------------------------------
% UCL's innoc is only 'cl', so grouptable_innoc = grouptable_controllance

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

%% this is the default example from SIMPLE pipeline, haven't customised yet
% Plot raw & jitter-corrected EEG average
% ----------------------------------------
% Using the table generated above, we can now plot the average 
% EEG traces to visually compare responses to the different events. 

time = ALLEEG(1).xmin:1/ALLEEG(1).srate:ALLEEG(1).xmax; time = time * 1000;
NRF_start = 400; NRFName = 'noxious_NRF_500Hz';
events = {'dummy','bg','cl','hl'};

plot_average_NRF_responses(grouptable, events, time, NRFName, NRF_start)

% plot control vs noxious NRF magnitudes
% ---------------------------------------
index_hl = ismember([datatable.Event], {'hl'});
index_cl = ismember([datatable.Event], {'cl'});

% to plot paired data, the samples must be the same size. You will get an
% error otherwise.

figure
gardnerAltmanPlot(NRFtable.Coef(index_cl), NRFtable.Coef(index_hl),'Paired',true)
set(gca,'XTickLabel',{'Control heel lance','Heel lance', 'Mean difference'})
ylabel('NRF magnitude')






