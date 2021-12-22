function [Rsqr,Rsqr_adj,Plane_Time_Dire,Speed,Wavelength_Grad] = RegressGradMethodSpectrum(ContinuesPhimatrix,Phimatrix)

        Rsqr = nan(1,size(Phimatrix,3));
        Rsqr_adj = nan(1,size(Phimatrix,3));
        Plane_Time_Dire = nan(1,size(Phimatrix,3));
        Gx = nan(size(ContinuesPhimatrix));
        Gy = nan(size(ContinuesPhimatrix));
        Speed = nan(1,size(Phimatrix,3));
        Wavelength_Grad = nan(1,size(Phimatrix,3));
        
    for TrailTime = 1:size(Phimatrix,3)
        %% Linear Regression
        [y,x] = meshgrid(1:size(Phimatrix,2),1:size(Phimatrix,1));
        z = (ContinuesPhimatrix(:,:,TrailTime));
        
        z = reshape(z,[1,size(z,1)*size(z,2)])';
        x = reshape(x,[1,size(x,1)*size(x,2)])';
        y = reshape(y,[1,size(y,1)*size(y,2)])';
        [x,y,z];
        X = [ones(size(x(~isnan(z)))),x(~isnan(z)),y(~isnan(z))];
        Y = z(~isnan(z))-mean(z(~isnan(z)));
        [b,bint,r,rint,stats] = regress(Y,X);
        LR_Dir = atan(-b(2)/b(3));
        LR_Dir = LR_Dir+(b(3)>0)*pi;
        
        Rsqr(TrailTime) = stats(1);
        
        n = sum(sum(~isnan(Phimatrix(:,:,TrailTime))));
        k = 3;
        Rsqr_adj(TrailTime) = 1-((1-stats(1))*(n-1)/(n-k-1)); % Adjusted Rsqaure
        
        % Wave Propagation direction
                K = NaN;
        cntr = -1;
        while isnan(K)
            cntr = cntr+1;
            K = (ContinuesPhimatrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime)/(2*pi));
        end
        
        if TrailTime>1
            flag = ContinuesPhimatrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime)-...
                ContinuesPhimatrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime-1);
            Plane_Time_Dire(TrailTime) = mod(LR_Dir + pi*(flag>0)+pi,2*pi);
        end
        
        
        %% Gradient Methode 
        
                [Gx(:,:,TrailTime),Gy(:,:,TrailTime)] = ...
            gradient(flip(ContinuesPhimatrix(:,:,TrailTime)));
       
        
        % Speed
        if TrailTime>1
            Phi_dot = reshape(ContinuesPhimatrix(:,:,TrailTime)...
                -ContinuesPhimatrix(:,:,TrailTime-1),[1,size(Gx,1)*size(Gx,2)]);
            Speed(TrailTime) = abs(nanmean(Phi_dot))/nanmean(sqrt(Xgrad.^2+Ygrad.^2)) * (0.4/5);
        end
        
        
        
        % Wavelength
        Mean_Phi = mod(Phimatrix(floor(end/2)+cntr,floor(end),TrailTime),2*pi);
        [Gx(:,:,TrailTime),Gy(:,:,TrailTime)] =...
            gradient(flip(ContinuesPhimatrix(:,:,TrailTime)+pi/2*(Mean_Phi<0.2)));
        
        WL_method = 2;
        switch WL_method
            case 1
                Xgrad = reshape(Gx(:,:,TrailTime),[1,size(Gx,1)*size(Gx,2)])';
                Ygrad = reshape(Gy(:,:,TrailTime),[1,size(Gy,1)*size(Gy,2)])';
                Wavelength_Grad(TrailTime) = 2*pi/sqrt(nanmean(Xgrad).^2+nanmean(Ygrad).^2)*0.4;
            case 2
                Xgrad = reshape(Gx(:,:,TrailTime),[1,size(Gx,1)*size(Gx,2)])';
                Ygrad = reshape(Gy(:,:,TrailTime),[1,size(Gy,1)*size(Gy,2)])';
                Wavelength_Grad(TrailTime) = 2*pi/nanmean(sqrt(Xgrad.^2+Ygrad.^2))*0.4;
        end
    end
end
