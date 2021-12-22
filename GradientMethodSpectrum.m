function [Speed,Wavelength_Grad] = GradientMethodSpectrum(ContinuesPhimatrix,Phimatrix)
        Gx = nan(size(ContinuesPhimatrix));
        Gy = nan(size(ContinuesPhimatrix));
        Speed = nan(1,size(Phimatrix,3));
        Wavelength_Grad = nan(1,size(Phimatrix,3));
    for TrailTime = 1:size(Phimatrix,3)
        %% Phase Gradient Plane
       
        % Calculate PGD
        [Gx(:,:,TrailTime),Gy(:,:,TrailTime)] = ...
            gradient(flip(ContinuesPhimatrix(:,:,TrailTime)));
%         Mag_of_MeanGrad = sqrt(sum(nansum(Gx(:,:,TrailTime)))^2+sum(nansum(Gy(:,:,TrailTime)))^2);
%         Mean_of_MagGrad = sum(nansum(sqrt(Gx(:,:,TrailTime).^2+Gy(:,:,TrailTime).^2)));
%         PGD(TrailTime) = Mag_of_MeanGrad/Mean_of_MagGrad;
        

        % Caclulate Direction
%         K = NaN;
%         cntr = -1;
%         while isnan(K)
%             cntr = cntr+1;
%             K = (ContinuesPhimatrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime)/(2*pi));
%         end
%         
%         if sum(nansum(Gx(:,:,TrailTime)))<0
%             Dir=  pi+atan(sum(nansum(Gy(:,:,TrailTime)))/sum(nansum(Gx(:,:,TrailTime))));
%         else
%             Dir=  atan(sum(nansum(Gy(:,:,TrailTime)))/sum(nansum(Gx(:,:,TrailTime))));
%         end
%         if TrailTime>1
%             flag = ContinuesPhimatrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime)-...
%                 ContinuesPhimatrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime-1);
%             Time_Dire(TrailTime) = Dir + pi*(flag>0);
%         end
        
        

       K = NaN;
        cntr = -1;
        while isnan(K)
            cntr = cntr+1;
            K = (ContinuesPhimatrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime)/(2*pi));
        end
        
        
        
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
