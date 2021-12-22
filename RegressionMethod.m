function [Rsqr,BethaVal,Rsqr_adj,Plane_Time_Dire,InstantDir,PGS,Regress_WaveLength,Regress_Speed] = ...
    RegressionMethod(ContinuesPhimatrix,Phi_matrix,Array_Pith_Size,Fs)

Rsqr = nan(1,size(Phi_matrix,3));
InstantDir = nan(1,size(Phi_matrix,3));
Rsqr_adj = nan(1,size(Phi_matrix,3));
Plane_Time_Dire = nan(1,size(Phi_matrix,3));

for TrailTime = 1:size(Phi_matrix,3)
    %% Linear Regression
    [y,x] = meshgrid(1:size(Phi_matrix,2),1:size(Phi_matrix,1));
    z = (Phi_matrix(:,:,TrailTime));
    
    z = reshape(z,[1,size(z,1)*size(z,2)])';
    x = reshape(x,[1,size(x,1)*size(x,2)])';
    y = reshape(y,[1,size(y,1)*size(y,2)])';
    [x,y,z];
    X = [ones(size(x(~isnan(z)))),x(~isnan(z)),y(~isnan(z))];
    Y = z(~isnan(z))-mean(z(~isnan(z)));
    
    [b,bint,r,rint,stats] = regress(Y,X);
    InstantDir(TrailTime) = atan(-b(2)/b(3));
    InstantDir(TrailTime) = InstantDir(TrailTime)+(b(3)>0)*pi;
    Rsqr(TrailTime) = stats(1);
    PGS(TrailTime) = 1 - sqrt(std(r)/(2*pi));
    BethaVal(:,TrailTime) = b;
    n = sum(sum(~isnan(Phi_matrix(:,:,TrailTime))));
    k = 3;
    Rsqr_adj(TrailTime) = 1-((1-stats(1))*(n-1)/(n-k-1)); % Adjusted Rsqaure
    
    .................. Wave Propagation direction
        K = NaN;
    cntr = -1;
    while isnan(K)
        cntr = cntr+1;
        K = (ContinuesPhimatrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime)/(2*pi));
    end
    
    if TrailTime>1
        flag = ContinuesPhimatrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime)-...
            ContinuesPhimatrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime-1);
        Plane_Time_Dire(TrailTime) = InstantDir(TrailTime) + pi*(flag>0)+pi;
    end
    
    ..................................... WaveLength
        
x1fit = min(x):1:max(x);
x2fit = min(y):1:max(y);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = BethaVal(1,TrailTime) + BethaVal(2,TrailTime)*X1FIT + BethaVal(3,TrailTime)*X2FIT;
[column1, row1] = find(max(max(YFIT)) == YFIT);
[column2, row2] = find(min(min(YFIT)) == YFIT);
Regress_WaveLength(TrailTime) = (2*pi/range(reshape(YFIT,[1,numel(YFIT)])))*...
    sqrt((column1-column2)^2+(row1-row2)^2)*Array_Pith_Size;

Regress_WaveLength(TrailTime)=...
    2*pi/sqrt(BethaVal(2,TrailTime)^2+BethaVal(3,TrailTime).^2)*1*Array_Pith_Size;

%............................ Speed.............
if TrailTime>1
    Delta_Phi = abs(nanmean(reshape(ContinuesPhimatrix(:,:,TrailTime)...
        -ContinuesPhimatrix(:,:,TrailTime-1),[1,size(ContinuesPhimatrix,1)*size(ContinuesPhimatrix,2)])));
    Delta_Phi = abs(nanmean(reshape(circ_dist(ContinuesPhimatrix(:,:,TrailTime)...
        ,ContinuesPhimatrix(:,:,TrailTime-1)),[1,size(ContinuesPhimatrix,1)*size(ContinuesPhimatrix,2)])));
    Delta_t = (1000*Fs^-1);
    Phi_dot = Delta_Phi/Delta_t;
    Regress_Speed(TrailTime) = Phi_dot* Regress_WaveLength(TrailTime)/(2*pi);
end
end
end