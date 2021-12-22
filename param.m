global parameters

parameters.BF_values        = { [4, 8], ...     % Delta
                                [8, 12], ...    % Alpha
                                [12, 20], ...   % Low Beta
                                [20, 30], ...   % High Beta
                                [30, 45], ...   % Gamma
                                [45, 60], ...   % Gamma
                                [60, 70], ...   % Gamma
                                [70, 90] };     % Gamma

parameters.monkey_names     = {'MacDuff', 'Mojo'};
parameters.epoch_values     = {'cue', 'reward'};
parameters.PR_values        = {0, 1};
parameters.PR_str_values    = {'PN', 'PR'};
parameters.TYPE_values      = {'C0', 'C52', 'C25', 'C57', 'C50', 'C75', 'C100', 'R25', 'R50', 'R75'};
parameters.TYPE_interest    = [1, 7]; % C0 and C100
parameters.CPOS_values      = {-1, 1};
parameters.CPOS_str_values  = {'L', 'R'};

data_folder = 'C:\Users\Erfan\Desktop\Uncertainty Data\Erfan Clean Data\';
tmp_folder_list = dir(data_folder);
all_file_names = {tmp_folder_list.name};

for monkey_index = 1: length(parameters.monkey_names)
for epoch_index =  1: length(parameters.epoch_values)
monkey_name = parameters.monkey_names{monkey_index};
epoch = parameters.epoch_values{epoch_index};

parameters.SESS_values{monkey_index, epoch_index} = ...
            all_file_names(~cellfun(@isempty, strfind(all_file_names, monkey_name)) & ...
                           ~cellfun(@isempty, strfind(all_file_names, epoch)));
end
end

clear data_folder tmp_folder_list all_file_names monkey_index epoch_index monkey_name epoch;
                        
                        
parameters.POI              = {{[0.4, 0.8]}, ...
                               {[-0.377, 0], [0, 0.4], [0.4, 0.8]}}; % Periods of interest
parameters.FOI              = {[5, 40], [45, 100]};
% parameters.FACTOR_values    = {'PR/PNR', 'CR/CNR', 'interaction'};
parameters.p_threshold      = 0.05;
parameters.power_threshold  = 0.4;
parameters.ARR_values       = {'PFC', 'PPC'};
parameters.Array_Pith_Size = 0.4; % physical distance between neighboring electrodes in mm
parameters.Fs = 200;  % LFP Sampeling Rate
