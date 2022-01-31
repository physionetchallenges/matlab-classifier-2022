function features = get_features(header,recordings) %get_ECGLeads_features

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Extract features from PCG recordings
% Inputs:
% 1. Header data
% 2. The recordings
%
% Outputs:
% features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

age_group=get_age(header);

if strcmpi(age_group,'neonate')
    age=0.5;
elseif strcmpi(age_group,'infant')
    age=6;
elseif strcmpi(age_group,'child')
    age=6*12;
elseif strcmpi(age_group,'adolescent')
    age=15*12;
elseif strcmpi(age_group,'young adult')
    age=20*12;
else
    age=0;
end

sex_group=get_sex(header);
if strcmpi(sex_group,'male')
    sex=0;
elseif strcmpi(sex_group,'female')
    sex=1;
else
    sex=2;
end

height=get_height(header);
weight=get_weight(header);

recording_locations={'AV','MV','PV','TV'};
num_recording_locations=length(recording_locations);

recording_features=zeros(num_recording_locations,4);

locations=get_locations(header);
num_locations=length(locations);

for j=1:num_locations

    ind=strmatch(locations{j},recording_locations);

    recording_features(ind,1)=mean(abs(recordings{j}));
    recording_features(ind,2)=var(recordings{j});
    recording_features(ind,3)=skewness(recordings{j});
    recording_features(ind,4)=1;

end

recording_features=recording_features(:);

features=[recording_features' age sex height weight];

end

function age_group=get_age(header)

age_group=header(startsWith(header,'#Age'));
age_group=strsplit(age_group{1},':');
age_group=strtrim(age_group{2});

end

function sex=get_sex(header)

sex=header(startsWith(header,'#Sex'));
sex=strsplit(sex{1},':');
sex=strtrim(sex{2});

end

function height=get_height(header)

height=header(startsWith(header,'#Height'));
height=strsplit(height{1},':');
height=strtrim(height{2});
height=str2double(height);

if isnan(height)
    height=0;
end

end

function weight=get_weight(header)

weight=header(startsWith(header,'#Weight'));
weight=strsplit(weight{1},':');
weight=strtrim(weight{2});
weight=str2double(weight);

if isnan(weight)
    weight=0;
end

end

function locations=get_locations(header)

num_locations=strsplit(header{1},' ');
num_locations=str2double(num_locations{2});

locations={};

for j=2:num_locations+1

    current_line=strsplit(header{j},' ');
    locations{j-1}=current_line{1};

end

end
