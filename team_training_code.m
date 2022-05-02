function model = team_training_code(input_directory,output_directory) % train_PCG_classifier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Train PCG classifiers and obtain the models
% Inputs:
% 1. input_directory
% 2. output_directory
%
% Outputs:
% 1. model: trained model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find text files
patient_files=dir(fullfile(input_directory,'*.txt'));
patient_files={patient_files.name};
patient_files=sort(patient_files); % To help debugging
num_patient_files=length(patient_files);

fprintf('Loading data for %d patients...\n', num_patient_files)

% Extract classes from data
classes_murmur={};
classes_outcome={};
for j=1:num_patient_files

    current_class_murmur=get_class_murmur(fullfile(input_directory,patient_files{j}));
    classes_murmur=unique([classes_murmur current_class_murmur]);

    current_class_outcome=get_class_outcome(fullfile(input_directory,patient_files{j}));
    classes_outcome=unique([classes_outcome current_class_outcome]);

end

classes_murmur=sort(classes_murmur);
num_classes_murmur=length(classes_murmur);

classes_outcome=sort(classes_outcome);
num_classes_outcome=length(classes_outcome);

% Extracting features and labels
disp('Extracting features and labels...')

features=[];
labels_murmur=categorical;
labels_outcome=categorical;

for j=1:num_patient_files

    fprintf('%d/%d \n',j,num_patient_files)

    current_header=get_header(fullfile(input_directory,patient_files{j}));
    current_recordings=load_recordings(input_directory,current_header);

    current_features=get_features(current_header, current_recordings);
    features(j,:) = current_features(:);

    labels_murmur(j)=get_class_murmur(fullfile(input_directory,patient_files{j}));
    labels_outcome(j)=get_class_outcome(fullfile(input_directory,patient_files{j}));

end

%% train RF

disp('Training the model...')

model_murmur = TreeBagger(300,features,labels_murmur);

model_outcome = TreeBagger(300,features,labels_outcome);

save_model(model_murmur,classes_murmur,model_outcome,classes_outcome,output_directory);

disp('Done.')

end

function save_model(model_murmur,classes_murmur,model_outcome,classes_outcome,output_directory) %save_PCG_model
% Save results.
filename = fullfile(output_directory,'model.mat');
save(filename,'model_murmur','classes_murmur','model_outcome','classes_outcome','-v7.3');

disp('Done.')
end

function class=get_class_murmur(input_header)

current_header=get_header(input_header);

class=current_header(startsWith(current_header,'#Murmur'));
class=strsplit(class{1},':');
class=strtrim(class{2});

end

function class=get_class_outcome(input_header)

current_header=get_header(input_header);

class=current_header(startsWith(current_header,'#Outcome'));
class=strsplit(class{1},':');
class=strtrim(class{2});

end

function current_header=get_header(input_header)

current_header=fileread(input_header);
current_header=strsplit(current_header,'\n');

end

function current_recordings=load_recordings(input_directory,current_header)

recording_files=get_recording_files(current_header);

current_recordings={};

for j=1:length(recording_files)

    current_recordings{j}=audioread(fullfile(input_directory,strtrim(recording_files{j})));

end

end

function recording_files=get_recording_files(current_header)

recording_files={};

num_locations=strsplit(current_header{1},' ');
num_locations=str2double(num_locations{2});

for j=2:num_locations+1

    current_line=strsplit(current_header{j},' ');
    recording_files{j-1}=current_line{3};

end

end
