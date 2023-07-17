%% Trials classification based on their condition
event  = recursive_read(data, 'event');
condition = [];
PR = [];
for i = 1:numel(data.trial)
    condition{i} = event(i).type;
    PR{i} = num2str(event(i).pre_reward_values);
end
PR_finde= [];
NPR_finde = [];

PR_finde = (strcmp(PR,{'0.25'}) + strcmp(PR,{'0.5'})+strcmp(PR,{'0.75'})+ strcmp(PR,{'1'}));
PR_index = find(PR_finde);
NPR_finde = strcmp(PR,{'0'});
NPR_index = find(NPR_finde);

i_cues = [PR_index,NPR_index]; % if you want to delet pre reward NaN trails ....
string_cues={'PR' 'NP'};

RM = NaN(size(data.trial));
RP = NaN(size(data.trial));
Cue_Pos = NaN(size(data.trial));

%% Define reward variable parameters from their labels 
for i = 1:numel(data.trial)
    Type = event(i).type;
    %................ Reward Magnetude.....................
    counter = 0;
    if strcmp(Type(1),'C')
        if strcmp(Type(end-1),'2')|| strcmp(Type(end-1),'7')
            counter = counter +1;
            RM(i) = 0.5;
        else
            RM(i) = 1;
        end
    else
        RM(i) =  str2num(Type(2:end-1))/100;
    end
    %................Reward Probability ...................
    
    if strcmp(Type(1),'C')
        if strcmp(Type(end-1),'2')
            RP(i) = 0.25;
        elseif strcmp(Type(end-1),'7')
            RP(i) = 0.75;
        else
            RP(i) = str2num(Type(2:end-1))/100;
        end
        
    else
        RP(i) = 1;
    end
    
    % a{i} =  [num2str(RP(i)),' ',Type]
    
    %........................Cue position..................
    Cue_Pos(i) = event(i).cue_pos;
end
