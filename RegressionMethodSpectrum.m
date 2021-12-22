function [Rsqr,Rsqr_adj,Plane_Time_Dire] = RegressionMethodSpectrum(Continues_Phi_matrix,Phi_matrix)

        Rsqr = nan(1,size(Phi_matrix,3));
        Rsqr_adj = nan(1,size(Phi_matrix,3));
        Plane_Time_Dire = nan(1,size(Phi_matrix,3));
        
    for TrailTime = 1:size(Phi_matrix,3)
        %% Linear Regression
        [y,x] = meshgrid(1:size(Phi_matrix,2),1:size(Phi_matrix,1));
        z = (Continues_Phi_matrix(:,:,TrailTime));
        
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
        
        n = sum(sum(~isnan(Phi_matrix(:,:,TrailTime))));
        k = 3;
        Rsqr_adj(TrailTime) = 1-((1-stats(1))*(n-1)/(n-k-1)); % Adjusted Rsqaure
        
        % Wave Propagation direction
                K = NaN;
        cntr = -1;
        while isnan(K)
            cntr = cntr+1;
            K = (Continues_Phi_matrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime)/(2*pi));
        end
        
        if TrailTime>1
            flag = Continues_Phi_matrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime)-...
                Continues_Phi_matrix(floor(end/2)+cntr,floor(end/2)+cntr,TrailTime-1);
            Plane_Time_Dire(TrailTime) = mod(LR_Dir + pi*(flag>0)+pi,2*pi);
        end
    end
end
