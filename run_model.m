function run_model(model_directory,input_directory, output_directory)

% Do *not* edit this script. Changes will be discarded so that we can process the models consistently.

% This file contains functions for running models for the 2022 Challenge. You can run it as follows:
%
%   run_model(model, data, outputs)
%
% where 'model' is a folder containing the your trained model, 'data' is a folder containing the Challenge data, and 'outputs' is a
% folder for saving your model's outputs.

% Load the model
loaded_model=load_model(model_directory);

% Find patient files
patient_files=dir(fullfile(input_directory,'*.txt'));
patient_files={patient_files.name};
patient_files=sort(patient_files); % To help debugging
num_patient_files=length(patient_files);

fprintf('Loading data for %d patients...\n', num_patient_files)

% Create the output directory if it doesn't exist
if ~exist(output_directory, 'dir')
    mkdir(output_directory)
end

% Run the model
disp('Running the model on the Challenge data...')

for j=1:num_patient_files

    fprintf('%d/%d \n',j,num_patient_files);

    current_header=get_header(fullfile(input_directory,patient_files{j}));
    current_recordings=load_recordings(input_directory,current_header);

    % Make the prediction
    [score, label, classes] = team_testing_code(current_header,current_recordings,loaded_model);

    % Save the predictions
    current_id=strsplit(current_header{1},' ');
    current_id=current_id{1};
    save_challenge_predictions(output_directory,score,label,classes,current_id);

end

disp('Done.')
end

% Save predictions
function save_challenge_predictions(output_directory, scores, labels,classes, recording)

output_file = fullfile(output_directory,strcat(recording,'.csv'));

total_classes = strjoin(string(classes),','); %insert commaas
fid = fopen(output_file,'w');
fprintf(fid,'#%s\n',recording);
fprintf(fid,'%s\n',total_classes);
fclose(fid);

%write data to end of file
dlmwrite(output_file,labels,'delimiter',',','-append','precision',4);
dlmwrite(output_file,scores,'delimiter',',','-append','precision',4);

end

% Load header
function current_header=get_header(input_header)

current_header=fileread(input_header);
current_header=strsplit(current_header,'\n');

end

% Load recordings
function current_recordings=load_recordings(input_directory,current_header)

recording_files=get_recording_files(current_header);

current_recordings={};

for j=1:length(recording_files)

    current_recordings{j}=audioread(fullfile(input_directory,strtrim(recording_files{j})));

end

end

% Get recording files from header
function recording_files=get_recording_files(current_header)

recording_files={};

num_locations=strsplit(current_header{1},' ');
num_locations=str2double(num_locations{2});

for j=2:num_locations+1

    current_line=strsplit(current_header{j},' ');
    recording_files{j-1}=current_line{3};

end

end
