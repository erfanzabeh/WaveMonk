%% Calcualte Oscilation matrix
function Oscil_matrix = OscilationFrequencyMatrix(S_NoiseCancel,f_NoiseCancel,monkey_index,slope)

if monkey_index==2
    monkey_name = 'Mojo';
else
    monkey_name = 'MacDuff';
end

funstr = str2func(['new_electrodepinout',monkey_name]);
Oscil_matrix = NaN([size(funstr('chan')),2]);

for  channel = 1:96
  if ~isnan(S_NoiseCancel{channel})
    [row,col,Ant_index] = chan_position(channel,monkey_name);
    %     sort((log10(S{channel})-slope(channel)*log10(f)'),'descend')
    [~,start_freq] = min(abs(f_NoiseCancel-2)); %2 Hz
    [~,end_freq] = min(abs(f_NoiseCancel-50));  %50 Hz
    Y = log10(S_NoiseCancel{channel}(start_freq:end_freq));
    X = log10(f_NoiseCancel(start_freq:end_freq))';
    
    [freqval, freq] = max(Y-slope(channel)*X);
    freq = f_NoiseCancel(freq+start_freq-1);
    Oscil_matrix(row,col,Ant_index) = freq;
  end
end
end
