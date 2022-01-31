%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Run trained PCG classifier and obtain classifier outputs
% Inputs:
% 1. header
% 2. recordings
% 3. trained model
%
% Outputs:
% 1. score
% 2. label
% 3. classes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [score, label, classes] = team_testing_code(header, recordings, loaded_model)

classes=loaded_model.classes;

features=get_features(header,recordings);
[label_tmp,score]=loaded_model.model.predict(features);

label=zeros(1,length(classes));
label(strmatch(label_tmp,classes))=1;

end
