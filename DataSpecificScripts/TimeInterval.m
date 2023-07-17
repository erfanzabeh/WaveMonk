%% Define Time Intervals
function [start_index, end_index,Time] = TimeInterval(epoch_index,data)
if isstruct(data)
    if epoch_index==1
        time_interval = [-1.2,2]; % Cue onset
        time_shift = 0;
    else
        time_interval = [-0.4,1.6]; % Reward onset
        time_shift = 0;
    end
    [~,start_index] = min((data.time{1}-time_interval(1)).^2);
    [~,end_index] = min((data.time{1}-time_interval(2)).^2);
    
    Time= data.time{1};
else
    Time = data;
    
    if epoch_index==1
        time_interval = [-1.2,2]; % Cue onset
        time_shift = 0;
    else
        time_interval = [-0.4,1.6]; % Reward onset
        time_shift = 0;
    end
    [~,start_index] = min((Time-time_interval(1)).^2);
    [~,end_index] = min((Time-time_interval(2)).^2);
end
end
