%% set working dir and paths

clear;

% Get path of current script
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));

% Confirm
disp(['Working directory set to: ', pwd]);

path_to_input_folder = '../../data';

path_to_output_folder = '../../result';

dataframe = 'reliability assessment_responses_cleaned.csv';

%% Tresponse

Tresponse = readtable(fullfile(path_to_input_folder,dataframe));
Tresponse.Timestamp = extractAfter(Tresponse.Timestamp,"Figure "); % extract the figure numbers only for the table column

%% Tepochid

filename = 'epoch_figureID.csv';

Tepochid = readtable(fullfile(path_to_input_folder,filename));

%% combining those two tables

Tresponse.Timestamp = str2double(Tresponse.Timestamp);

% concatenate rows of first ID and second ID vertically, and rename the
% column for ID to 'id'
part1 = Tepochid(:,{'epoch' 'first_id'});
part2 = Tepochid(:,{'epoch' 'second_id'});

part1.Properties.VariableNames{'first_id'} = 'id';
part2.Properties.VariableNames{'second_id'} = 'id';

Tepochidfinal = [part1;part2];

Tresponse.Properties.VariableNames{'Timestamp'} = 'id';

% join table responses with table epochid
Tresult = join(Tresponse,Tepochidfinal,"Keys","id");

% save the table
tablename = 'epoch_id_responses.csv';
writetable(Tresult,fullfile(path_to_output_folder, tablename))

%% prepare the table for inter-rater and intra-rater reliability assessment

[~,firstsubjectindex] = unique(Tresult.epoch); % only take the first occurence of a subject (removes duplicate)
[~,lastsubjectindex] = unique(Tresult.epoch,'last','legacy'); % take the second (last) occurence of an epoch

% for inter-rater, we are going to test with 4 combinations: rater 1
% occasion 1 x rater 2 occasion 1; r1o1 x r2o2; r1o2 x r2o1; r1o2 x r2o2
Tinterrater_r1o1_r2o1 = Tresult(firstsubjectindex,:); 
Tinterrater_r1o2_r2o2 = Tresult(lastsubjectindex,:); 

Tinterrater_r1o1 = Tinterrater_r1o1_r2o1(:,["r1" "epoch"]);
Tinterrater_r1o2 = Tinterrater_r1o2_r2o2(:,["r1" "epoch"]);

Tinterrater_r2o1 = Tinterrater_r1o1_r2o1(:,["r2" "epoch"]);
Tinterrater_r2o2 = Tinterrater_r1o2_r2o2(:,["r2" "epoch"]);

Tinterrater_r1o1_r2o2 = join(Tinterrater_r1o1,Tinterrater_r2o2);
Tinterrater_r1o2_r2o1 = join(Tinterrater_r1o2,Tinterrater_r2o1);

% for intra-rater, we are interested in the rates of the first occurences
% AND the second ones
% rater 1
Tintrarater_o1 = Tresult(firstsubjectindex,["r1" "epoch"]);
Tintrarater_o1.Properties.VariableNames{'r1'} = 'r1o1';
Tintrarater_o2 = Tresult(lastsubjectindex,["r1" "epoch"]);
Tintrarater_o2.Properties.VariableNames{'r1'} = 'r1o2';
Tintrarater1 = join(Tintrarater_o1,Tintrarater_o2);
Tintrarater1 = movevars(Tintrarater1,'epoch','Before','r1o1');

% rater 2
Tintrarater_o1 = Tresult(firstsubjectindex,["r2" "epoch"]);
Tintrarater_o1.Properties.VariableNames{'r2'} = 'r2o1';
Tintrarater_o2 = Tresult(lastsubjectindex,["r2" "epoch"]);
Tintrarater_o2.Properties.VariableNames{'r2'} = 'r2o2';
Tintrarater2 = join(Tintrarater_o1,Tintrarater_o2);
Tintrarater2 = movevars(Tintrarater2,'epoch','Before','r2o1');

% save the table
tablename_inter_r1o1_r2o1 = 'epoch_id_responses_interrater_r1o1_r2o1.csv';
tablename_inter_r1o1_r2o2 = 'epoch_id_responses_interrater_r1o1_r2o2.csv';
tablename_inter_r1o2_r2o1 = 'epoch_id_responses_interrater_r1o2_r2o1.csv';
tablename_inter_r1o2_r2o2 = 'epoch_id_responses_interrater_r1o2_r2o2.csv';

tablename_intra1 = 'epoch_id_responses_intrarater1.csv';
tablename_intra2 = 'epoch_id_responses_intrarater2.csv';

writetable(Tinterrater_r1o1_r2o1,fullfile(path_to_output_folder, tablename_inter_r1o1_r2o1))
writetable(Tinterrater_r1o2_r2o2,fullfile(path_to_output_folder, tablename_inter_r1o2_r2o2))
writetable(Tinterrater_r1o1_r2o2,fullfile(path_to_output_folder, tablename_inter_r1o1_r2o2))
writetable(Tinterrater_r1o2_r2o1,fullfile(path_to_output_folder, tablename_inter_r1o2_r2o1))

writetable(Tintrarater1,fullfile(path_to_output_folder, tablename_intra1))
writetable(Tintrarater2,fullfile(path_to_output_folder, tablename_intra2))

%% sort responses by sites

ox_nox = 'dataframe_ox_nox.csv'; % only noxious events were included in reliability assessment
ex_nox = 'dataframe_ex_heellance.csv';
ucl_nox = 'dataframe_ucl_heellance.csv';

% oxford
ox_nox = readtable(fullfile(path_to_output_folder,ox_nox));
id_ox = unique(ox_nox.File);

% exeter
ex_nox = readtable(fullfile(path_to_output_folder,ex_nox));
id_ex = unique(ex_nox.File);

% ucl
ucl_nox = readtable(fullfile(path_to_output_folder,ucl_nox));
id_ucl = unique(ucl_nox.File);

%% r1o1_r2o1------

% oxford
id_ox_table = cell2table(id_ox,"VariableNames","epoch");
comparison_ox = ismember(Tinterrater_r1o1_r2o1.epoch,id_ox_table.epoch);
r1o1_r2o1_ox1 = Tinterrater_r1o1_r2o1(comparison_ox,:);

% exeter
id_ex_table = cell2table(id_ex,"VariableNames","epoch");
comparison_ex = ismember(Tinterrater_r1o1_r2o1.epoch,id_ex_table.epoch);
r1o1_r2o1_ex = Tinterrater_r1o1_r2o1(comparison_ex,:);

% ucl
id_ox_ex = [id_ox;id_ex];
id_ox_ex_table = cell2table(id_ox_ex,"VariableNames","epoch");
comparison_ox_ex = ismember(Tinterrater_r1o1_r2o1.epoch,id_ox_ex_table.epoch);
r1o1_r2o1_ucl1 = Tinterrater_r1o1_r2o1(~comparison_ox_ex,:);

indexOx = startsWith(r1o1_r2o1_ucl1.epoch, "Ox") | startsWith(r1o1_r2o1_ucl1.epoch, "P");
originally_ox = r1o1_r2o1_ucl1(indexOx,:);
r1o1_r2o1_ox = [r1o1_r2o1_ox1;originally_ox];
r1o1_r2o1_ucl = r1o1_r2o1_ucl1(~indexOx,:);

%% r1o1_r2o2-----

% oxford
comparison_ox = ismember(Tinterrater_r1o1_r2o2.epoch,id_ox_table.epoch);
r1o1_r2o2_ox1 = Tinterrater_r1o1_r2o2(comparison_ox,:);

% exeter
comparison_ex = ismember(Tinterrater_r1o1_r2o2.epoch,id_ex_table.epoch);
r1o1_r2o2_ex = Tinterrater_r1o1_r2o2(comparison_ex,:);

% ucl
comparison_ox_ex = ismember(Tinterrater_r1o1_r2o2.epoch,id_ox_ex_table.epoch);
r1o1_r2o2_ucl1 = Tinterrater_r1o1_r2o2(~comparison_ox_ex,:);

indexOx = startsWith(r1o1_r2o2_ucl1.epoch, "Ox") | startsWith(r1o1_r2o2_ucl1.epoch, "P");
originally_ox = r1o1_r2o2_ucl1(indexOx,:);
r1o1_r2o2_ox = [r1o1_r2o2_ox1;originally_ox];
r1o1_r2o2_ucl = r1o1_r2o2_ucl1(~indexOx,:);

%% r1o2_r2o1-----

% oxford
comparison_ox = ismember(Tinterrater_r1o2_r2o1.epoch,id_ox_table.epoch);
r1o2_r2o1_ox1 = Tinterrater_r1o2_r2o1(comparison_ox,:);

% exeter
comparison_ex = ismember(Tinterrater_r1o2_r2o1.epoch,id_ex_table.epoch);
r1o2_r2o1_ex = Tinterrater_r1o2_r2o1(comparison_ex,:);

% ucl
comparison_ox_ex = ismember(Tinterrater_r1o2_r2o1.epoch,id_ox_ex_table.epoch);
r1o2_r2o1_ucl1 = Tinterrater_r1o2_r2o1(~comparison_ox_ex,:);

indexOx = startsWith(r1o2_r2o1_ucl1.epoch, "Ox") | startsWith(r1o2_r2o1_ucl1.epoch, "P");
originally_ox = r1o2_r2o1_ucl1(indexOx,:);
r1o2_r2o1_ox = [r1o2_r2o1_ox1;originally_ox];
r1o2_r2o1_ucl = r1o2_r2o1_ucl1(~indexOx,:);

%% r1o2_r2o2-----

% oxford
comparison_ox = ismember(Tinterrater_r1o2_r2o2.epoch,id_ox_table.epoch);
r1o2_r2o2_ox1 = Tinterrater_r1o2_r2o2(comparison_ox,:);

% exeter
comparison_ex = ismember(Tinterrater_r1o2_r2o2.epoch,id_ex_table.epoch);
r1o2_r2o2_ex = Tinterrater_r1o2_r2o2(comparison_ex,:);

% ucl
comparison_ox_ex = ismember(Tinterrater_r1o2_r2o2.epoch,id_ox_ex_table.epoch);
r1o2_r2o2_ucl1 = Tinterrater_r1o2_r2o2(~comparison_ox_ex,:);

indexOx = startsWith(r1o2_r2o2_ucl1.epoch, "Ox") | startsWith(r1o2_r2o2_ucl1.epoch, "P");
originally_ox = r1o2_r2o2_ucl1(indexOx,:);
r1o2_r2o2_ox = [r1o2_r2o2_ox1;originally_ox];
r1o2_r2o2_ucl = r1o2_r2o2_ucl1(~indexOx,:);

%% r1o1_r1o2 (intra_rater 1)

% oxford
comparison_ox = ismember(Tintrarater1.epoch,id_ox_table.epoch);
r1_ox1 = Tintrarater1(comparison_ox,:);

% exeter
comparison_ex = ismember(Tintrarater1.epoch,id_ex_table.epoch);
r1_ex = Tintrarater1(comparison_ex,:);

% ucl
comparison_ox_ex = ismember(Tintrarater1.epoch,id_ox_ex_table.epoch);
r1_ucl1 = Tintrarater1(~comparison_ox_ex,:);

indexOx = startsWith(r1_ucl1.epoch, "Ox") | startsWith(r1_ucl1.epoch, "P");
originally_ox = r1_ucl1(indexOx,:);
r1_ox = [r1_ox1;originally_ox];
r1_ucl = r1_ucl1(~indexOx,:);

%% r2o1_r2o2 (intra_rater 2)

% oxford
comparison_ox = ismember(Tintrarater2.epoch,id_ox_table.epoch);
r2_ox1 = Tintrarater2(comparison_ox,:);

% exeter
comparison_ex = ismember(Tintrarater2.epoch,id_ex_table.epoch);
r2_ex = Tintrarater2(comparison_ex,:);

% ucl
comparison_ox_ex = ismember(Tintrarater2.epoch,id_ox_ex_table.epoch);
r2_ucl1 = Tintrarater2(~comparison_ox_ex,:);

indexOx = startsWith(r2_ucl1.epoch, "Ox") | startsWith(r2_ucl1.epoch, "P");
originally_ox = r2_ucl1(indexOx,:);
r2_ox = [r2_ox1;originally_ox];
r2_ucl = r2_ucl1(~indexOx,:);

%% save all the tables by sites
% 3sites * 4 inter-rater = 12 inter-raters
tablename_inter_r1o1_r2o1_ox = 'epoch_id_responses_interrater_r1o1_r2o1_ox.csv';
tablename_inter_r1o1_r2o1_ex = 'epoch_id_responses_interrater_r1o1_r2o1_ex.csv';
tablename_inter_r1o1_r2o1_ucl = 'epoch_id_responses_interrater_r1o1_r2o1_ucl.csv';

tablename_inter_r1o1_r2o2_ox = 'epoch_id_responses_interrater_r1o1_r2o2_ox.csv';
tablename_inter_r1o1_r2o2_ex = 'epoch_id_responses_interrater_r1o1_r2o2_ex.csv';
tablename_inter_r1o1_r2o2_ucl = 'epoch_id_responses_interrater_r1o1_r2o2_ucl.csv';

tablename_inter_r1o2_r2o1_ox = 'epoch_id_responses_interrater_r1o2_r2o1_ox.csv';
tablename_inter_r1o2_r2o1_ex = 'epoch_id_responses_interrater_r1o2_r2o1_ex.csv';
tablename_inter_r1o2_r2o1_ucl = 'epoch_id_responses_interrater_r1o2_r2o1_ucl.csv';

tablename_inter_r1o2_r2o2_ox = 'epoch_id_responses_interrater_r1o2_r2o2_ox.csv';
tablename_inter_r1o2_r2o2_ex = 'epoch_id_responses_interrater_r1o2_r2o2_ex.csv';
tablename_inter_r1o2_r2o2_ucl = 'epoch_id_responses_interrater_r1o2_r2o2_ucl.csv';

% 3sites * 2 intra-rater = 6 intra-raters
tablename_intra1_ox = 'epoch_id_responses_intrarater1_ox.csv';
tablename_intra1_ex = 'epoch_id_responses_intrarater1_ex.csv';
tablename_intra1_ucl = 'epoch_id_responses_intrarater1_ucl.csv';

tablename_intra2_ox = 'epoch_id_responses_intrarater2_ox.csv';
tablename_intra2_ex = 'epoch_id_responses_intrarater2_ex.csv';
tablename_intra2_ucl = 'epoch_id_responses_intrarater2_ucl.csv';

writetable(r1o1_r2o1_ox,fullfile(path_to_output_folder, tablename_inter_r1o1_r2o1_ox))
writetable(r1o1_r2o1_ex,fullfile(path_to_output_folder, tablename_inter_r1o1_r2o1_ex))
writetable(r1o1_r2o1_ucl,fullfile(path_to_output_folder, tablename_inter_r1o1_r2o1_ucl))

writetable(r1o1_r2o2_ox,fullfile(path_to_output_folder, tablename_inter_r1o1_r2o2_ox))
writetable(r1o1_r2o2_ex,fullfile(path_to_output_folder, tablename_inter_r1o1_r2o2_ex))
writetable(r1o1_r2o2_ucl,fullfile(path_to_output_folder, tablename_inter_r1o1_r2o2_ucl))

writetable(r1o2_r2o1_ox,fullfile(path_to_output_folder, tablename_inter_r1o2_r2o1_ox))
writetable(r1o2_r2o1_ex,fullfile(path_to_output_folder, tablename_inter_r1o2_r2o1_ex))
writetable(r1o2_r2o1_ucl,fullfile(path_to_output_folder, tablename_inter_r1o2_r2o1_ucl))

writetable(r1o2_r2o2_ox,fullfile(path_to_output_folder, tablename_inter_r1o2_r2o2_ox))
writetable(r1o2_r2o2_ex,fullfile(path_to_output_folder, tablename_inter_r1o2_r2o2_ex))
writetable(r1o2_r2o2_ucl,fullfile(path_to_output_folder, tablename_inter_r1o2_r2o2_ucl))

writetable(r1_ox,fullfile(path_to_output_folder, tablename_intra1_ox))
writetable(r1_ex,fullfile(path_to_output_folder, tablename_intra1_ex))
writetable(r1_ucl,fullfile(path_to_output_folder, tablename_intra1_ucl))

writetable(r2_ox,fullfile(path_to_output_folder, tablename_intra2_ox))
writetable(r2_ex,fullfile(path_to_output_folder, tablename_intra2_ex))
writetable(r2_ucl,fullfile(path_to_output_folder, tablename_intra2_ucl))