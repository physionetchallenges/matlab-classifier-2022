function train_model(input_directory, output_directory)

% Do *not* edit this script. Changes will be discarded so that we can process the models consistently.

% This file contains functions for training models for the 2022 Challenge. You can run it as follows:
%
%   train_model(data, model)
%
% where 'data' is a folder containing the Challenge data and 'model' is a folder for saving your model.

if ~exist(output_directory, 'dir')
    mkdir(output_directory)
end

team_training_code(input_directory,output_directory); % Teams: Implement this function!!!

end
