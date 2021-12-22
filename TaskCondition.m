function   [RM,RP,E,Cue_Pos,Target_Pos,PR_val,Cur_Val,i_cues]= TaskCondition(event)
%% Trials classification based on their condition

% event  = recursive_read(data, 'event');
% event = EVENT{Array,monkey_index};

condition = [];
PR = [];
NmbrofTrl = numel(event);
for i = 1:NmbrofTrl
    condition{i} = event(i).type;
    PR{i} = num2str(event(i).pre_reward_values);
        PR_val(i,1) = sign(event(i).pre_reward_values);
        Cur_Val(i,1) = sign(event(i).value);
        if isnan(PR_val(i,1))
            PR_val(i,1) = nan;
        end
end
PR_finde= [];
NPR_finde = [];

PR_finde = (strcmp(PR,{'0.25'}) + strcmp(PR,{'0.5'})+strcmp(PR,{'0.75'})+ strcmp(PR,{'1'}));
PR_index = find(PR_finde);
NPR_finde = strcmp(PR,{'0'});
NPR_index = find(NPR_finde);



i_cues = [PR_index,NPR_index]; % if you want to delet pre reward NaN trails ....
string_cues={'PR' 'NP'};

RM = NaN([NmbrofTrl,1]);
RP = NaN([NmbrofTrl,1]);
Cue_Pos = NaN([NmbrofTrl,1]);
Target_Pos =  NaN([NmbrofTrl,1]);
E =  NaN([NmbrofTrl,1]);

%% Define reward variable parameters from their labels
for i = 1:NmbrofTrl
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
    
    %........................Cue position..................
    Cue_Pos(i) = event(i).cue_pos;
    %........................Target position..................
    Target_Pos(i) = event(i).target_pos;
        %........................Entropy..................
        
      P = RP(i);
      E(i) = -P.* log(P)- (1-P).*log((1-P));
      switch P
          case 0
              E(i) = 0;
          case 1
              E(i) = 0;
      end
end
end



