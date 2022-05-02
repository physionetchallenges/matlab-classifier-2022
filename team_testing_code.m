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

classes_murmur=loaded_model.classes_murmur;
classes_outcome=loaded_model.classes_outcome;

features=get_features(header,recordings);

[label_tmp_murmur,score_murmur]=loaded_model.model_murmur.predict(features);
label_murmur=zeros(1,length(classes_murmur));
label_murmur(strmatch(label_tmp_murmur,classes_murmur))=1;

[label_tmp_outcome,score_outcome]=loaded_model.model_outcome.predict(features);
label_outcome=zeros(1,length(classes_outcome));
label_outcome(strmatch(label_tmp_outcome,classes_outcome))=1;

classes=[classes_murmur classes_outcome];
score=[score_murmur score_outcome];

label=[label_murmur label_outcome];

end
