
function [Rsquared,direction,Phase_Velocity,Wavelength,spatial_frequency,temporal_frequency] = CircularMethod(PhiMatrix,Array_Pith_Size,Fs)
Rsquared = nan(1,size(PhiMatrix,3));
direction = nan(1,size(PhiMatrix,3));
spatial_frequency = nan(1,size(PhiMatrix,3));
% profile on
for TrialTime = 1:size(PhiMatrix,3)
    %% Phase Gradient Plane
    Phi = PhiMatrix(:,:,TrialTime);
    [x,y]= find(~isnan(Phi));
    linearV= [x,y];
    circularV = reshape(Phi,[numel(Phi),1]);
    circularV = circularV(~isnan(circularV));
    visulization = 0;
    [direction(TrialTime),spatial_frequency(TrialTime),sl,Rsquared(TrialTime)] = circ_lin_regress_2D(circularV,linearV,visulization);
end
% profile viewer
direction = direction+pi/2;
Wavelength = (1./spatial_frequency).*Array_Pith_Size;  %mm
delta_T = 1/Fs; %s
delta_phi = nanmean(reshape(circ_dist(PhiMatrix(:,:,2:TrialTime),PhiMatrix(:,:,1:TrialTime-1)),...
    [size(PhiMatrix,1)*size(PhiMatrix,2),size(PhiMatrix,3)-1]),1);
phi_dot= delta_phi/delta_T; 
temporal_frequency = 2*pi*phi_dot; % Hz
Phase_Velocity = 1e-3 * Wavelength(2:end).*temporal_frequency; % m/s^2
end
