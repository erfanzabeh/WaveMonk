function slope = PinkNoiseSlope(S_NoiseCancel,f_NoiseCancel,badLFPchannels)
slope = NaN(96,1);
for  channel = 1:96
    if ~sum(channel==badLFPchannels)
    [~,start_freq] = min(abs(f_NoiseCancel-2)); %2 Hz
    [~,end_freq] = min(abs(f_NoiseCancel-50));  %50 Hz 
   
    Y = log10(S_NoiseCancel{channel}(start_freq:end_freq));
    X = log10(f_NoiseCancel(start_freq:end_freq))';
    
    brob = robustfit(X,Y); % robust regression 
    [b,~,~,~,~]  = regress(Y,[ones(size(X)),X]); % regular regression (sensitive to the noise!)
    
%     slope(channel) = b(2);
    slope(channel) = brob(2); 
    end
%% Plot Noise SLope    
%     figure
%     plot(X,Y,'*')
%     hold on
%     estimated = b(1)+ X*b(2);
%     Roobust_estimated = brob(1)+ X*brob(2);
%     plot(X,estimated,'r');
%     plot(X,Roobust_estimated,'k');
end
end