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

disp('Loading data...')

% Find text files
header_files=dir(fullfile(input_directory,'*.txt'));
header_files={header_files.name};
header_files=sort(header_files); % To help debugging
num_header_files=length(header_files);

% Extract classes from data
classes={};
for j=1:num_header_files

    current_class=get_class(fullfile(input_directory,header_files{j}));
    classes=unique([classes current_class]);

end

classes=sort(classes);
num_classes=length(classes);

% Extracting features and labels
disp('Extracting features and labels...')

features=[];
labels=categorical;

for j=1:num_header_files

    fprintf('%d/%d \n',j,num_header_files)

    current_header=get_header(fullfile(input_directory,header_files{j}));
    current_recordings=load_recordings(input_directory,current_header);

    current_features=get_features(current_header, current_recordings);
    features(j,:) = current_features(:);

    labels(j)=get_class(fullfile(input_directory,header_files{j}));

end

%% train RF

model = TreeBagger(300,features,labels);
save_model(model,classes,output_directory);

end

function save_model(model,classes,output_directory) %save_PCG_model
% Save results.
filename = fullfile(output_directory,'model.mat');
save(filename,'model','classes','-v7.3');

disp('Done.')
end

function class=get_class(input_header)

current_header=get_header(input_header);

class=current_header(startsWith(current_header,'#Murmur'));
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
