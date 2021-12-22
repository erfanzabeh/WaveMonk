%% Notch filtering the data
function FilteredSignal = NotchFiltering(Fs,lowerlim,uperLim,Signal)
FilteredSignal = NaN(size(Signal));
% Fs is frequency of samplelling ;
% Signal has to be a matrix of n by m which m is number of trial and n is
% the number of signals samples 
d = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',lowerlim,'HalfPowerFrequency2',uperLim, ...
               'DesignMethod','butter','SampleRate',Fs);
for i = 1:size(Signal,2)
openLoop = Signal(:,i);         
% fvtool(d,'Fs',Fs)
buttLoop = filtfilt(d,openLoop);
FilteredSignal(:,i) = buttLoop;

% t = (0:length(openLoop)-1)/Fs;
% plot(t,openLoop,t,buttLoop)
% ylabel('Voltage (V)')
% xlabel('Time (s)')
% title('Open-Loop Voltage')
% legend('Unfiltered','Filtered')
% grid
%  
%
% [popen,fopen] = periodogram(openLoop,[],[],Fs);
% [pbutt,fbutt] = periodogram(buttLoop,[],[],Fs);
% 
% plot(fopen,20*log10(abs(popen)),fbutt,20*log10(abs(pbutt)),'--')
% ylabel('Power/frequency (dB/Hz)')
% xlabel('Frequency (Hz)')
% title('Power Spectrum')
% legend('Unfiltered','Filtered')
% grid
end