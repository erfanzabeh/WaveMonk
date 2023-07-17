function [direction,spatial_frequency,sl,Rsquared] = circ_lin_regress_2D(circularV,linearV,visulization)
% circ_lin_regress_2D is a function used to fit a 2D linear variables to a
% circular variable. One exmaple of the application is to fit phase traveling wave
% from linear coordinates.
%
% For method details, see Zabeh et al. 2023
%
% linearV is a N by 2 matrix convey the linear variables. circularV (in radian) is a N
% by 1 array, which we are trying to fit. The algorithm handles wrapping-up cases on its own.
% visulization is a logic variable. It generlizes 2 visualization plot. One is the residual.
%
% direction of circular variable ascending with linear variables. Please
% note the direction of wave propagation will be 180 degree from this
% number as wave propagates to phase descending direction.
% spatial_frequency is the change rate of circular variable to linear
% variables at the ascending direction. The unit is radian per linear unit
% sl is the slopes of phase change relative to each column in linearV.
% Rsquared donates how much variance of the circular
% variable is explain the regression model. To access the statitical
% significace, please perform a permutaion procedure.

if nargin<2
    disp('Incomplete input')
elseif nargin==2
    visulization=true;
end
pos_x = linearV(:,1);
pos_y = linearV(:,2);
phase = mod(circularV,2*pi);
%helper function to calculate Residual resultant vector length between
%fit and actual phase
myfun = @(slope1,slope2)sqrt((sum(cos(phase-slope1*pos_x-slope2*pos_y)/length(phase)).^2 + (sum(sin(phase-(slope1*pos_x)-slope2*pos_y))/length(phase)).^2));

% arrange range and steplength for parameter space. angle ranges 2pi
% and spatial frequency range from 0 to 18 degree per unit. the upper
% limit of spatial frequency is depend on the spatial nyquist
% frequency. You may change the steplength to anything but watch out
% for computation time.

% angle_range=pi*(0:1:360)/180;
% spatial_frequency_range=(0:.1:18)*pi/180;

angle_range=pi*(0:5:360)/180;
spatial_frequency_range=(0:1:18)*pi/180;

[angleMatrix,spatial_frequency_Matrix]=meshgrid(angle_range,spatial_frequency_range); % make it to a matrix for arrayfun

% transfer angle and spatial_frequency into 2d linear slopes
slope1_Matrix=cos(angleMatrix).*spatial_frequency_Matrix; % slope for pos_x
slope2_Matrix=sin(angleMatrix).*spatial_frequency_Matrix; % slope for pos_y
Residual_resultant_vector_length=arrayfun(myfun,slope1_Matrix,slope2_Matrix); % calculate the resultant_vector_length for each possible slope combos
[row,column]=find(Residual_resultant_vector_length==max(max(Residual_resultant_vector_length))); % find the largest resultant_vector_length

% Erfan edit 
row = max(row);
column = max(column);

%get the direction and spatial_frequency. If running traveling
%wave analysis, the direction should be flipped 180 degrees as waves
%propagates to the phase descending directions.
direction=angleMatrix(row,column); % find the best fit propagtion direciton
spatial_frequency=spatial_frequency_Matrix(row,column); % find the best fit spatial frequency

sl=spatial_frequency*[cos(direction) sin(direction)]; %transform to linear slopes

% calculate offset for fitted values
offs = atan2(sum(sin(phase-sl(1)*pos_x-sl(2)*pos_y)),sum(cos(phase-sl(1)*pos_x-sl(2)*pos_y))) ;

% circular-linear correlation:
pos_circ = mod(sl(1)*pos_x+sl(2)*pos_y+offs, 2*pi); % circular variable derived from the position
phase_mean = mod(angle(sum(exp(1i*phase))/length(phase)),2*pi); % circular mean of the theta phase
pos_circ_mean = mod(angle(sum(exp(1i*pos_circ))/length(phase)),2*pi); % circular mean of the circular position variable
cc = sum(sin(phase - phase_mean) .* sin(pos_circ - pos_circ_mean)) / sqrt( sum(sin(phase - phase_mean).^2) * sum(sin(pos_circ - pos_circ_mean).^2) );
% calculating the circ-correlation coefficient between measured phase and fitted
Rsquared=cc^2;
pos_circ=mod(pos_circ,2*pi);
if visulization
    figure % figure1 visualising resultant vector length on the parameter space.
    surf(slope1_Matrix,slope2_Matrix,Residual_resultant_vector_length) %make round parameter space.
    hold on
    scatter3(sl(1),sl(2),max(max(Residual_resultant_vector_length)),80,'k','filled')  % note the best fitting on parameter space
    shading('flat');colormap('jet');cb=colorbar;view(0,90);axis('off');axis('equal')
    set(get(cb,'Title') ,'String','R','fontsize',20);
    title('Residual resultant vector length on parameter space') %
    figure % figure2 visualising fitted plane and the residuals.
    [x_grid,y_grid]=meshgrid(linspace(min(pos_x),max(pos_x),50),linspace(min(pos_y),max(pos_y),50)); % make plane matrix
    mesh(x_grid,y_grid,mod(x_grid*sl(1)+y_grid*sl(2)+offs,2*pi),'facealpha',.5); % plot the fitted plane
    shading('flat');colormap('jet');cb=colorbar;
    set(get(cb,'Title') ,'String','Phase','fontsize',15);
    hold on
    for i=1:length(phase)
        scatter3(pos_x(i),pos_y(i),phase(i),60,'r','filled') % plot the real phase values
        plot3([pos_x(i),pos_x(i)],[pos_y(i),pos_y(i)],[phase(i),pos_circ(i)],'k','linewidth',2) % lineup the real phase values and the plane
    end
    title('Circular-linear regression data fitting');
    %axis square
end



