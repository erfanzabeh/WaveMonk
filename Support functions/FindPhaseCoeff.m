function K = FindPhaseCoeff(phase_interval,timesample)
pk = findpeaks(phase_interval,2*pi*(0.9));
K = zeros(numel(timesample),1);
for k = 1:numel(pk.loc)
    K = K+(timesample-pk.loc(k)>0)';
end
% if phase_interval(1)>3*pi/2
if phase_interval(1)>5
    K = K-1;
end
end
