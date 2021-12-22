function Continues_Phi_matrix = Periodic2ContinuesPhase2(Phi_matrix)
Continues_Phi_matrix = NaN(size(Phi_matrix));

switch numel(size(Phi_matrix))
    case 3
        timesample = 1:size(Phi_matrix,3);
        for i =  1:size(Phi_matrix,1)
            for j = 1:size(Phi_matrix,2)
                phase_interval = squeeze(Phi_matrix(i,j,:));
                K = FindPhaseCoeff(phase_interval,timesample);
                Continues_Phi_matrix(i,j,:) = phase_interval+ K*2*pi;
            end
        end
        for TrailTime = 1:size(Phi_matrix,3)
            %% smooth Continues phase
            PhaseProportion = Continues_Phi_matrix(:,:,TrailTime)./(2*pi);
            clustervector = reshape(PhaseProportion,[numel(PhaseProportion),1]);
            clustervector(isnan(clustervector)) = [];
            [idx,c] = kmeans(clustervector,ceil(range(clustervector)));
            cluster_indx_matrix = zeros(1,numel(c));
            for i  = 1:numel(c)
                cluster_indx_matrix(i) = ((sum(idx==i)/numel(idx)));
            end
            cluster_indx = find(cluster_indx_matrix ==max(cluster_indx_matrix));
            cluster_indx = cluster_indx(1);
            real_instnt_phase_mean = mean(clustervector(idx==cluster_indx));
            k = round(abs(PhaseProportion-real_instnt_phase_mean)+0.01);
            upsmooth = Continues_Phi_matrix(:,:,TrailTime) - 2*pi*k.*(PhaseProportion-...
                real_instnt_phase_mean>0.5);
            downsmooth = upsmooth + 2*pi*k.*(PhaseProportion-...
                real_instnt_phase_mean<-0.5);
            Continues_Phi_matrix(:,:,TrailTime) = downsmooth;
            
        end
        
    case 4
        for trailsample = 1:size(Phi_matrix,4)
            timesample = 1:size(Phi_matrix,3);
            for i =  1:size(Phi_matrix,1)
                for j = 1:size(Phi_matrix,2)
                    phase_interval = squeeze(Phi_matrix(i,j,:,trailsample));
                    K = FindPhaseCoeff(phase_interval,timesample);
                    Continues_Phi_matrix(i,j,:,trailsample) = phase_interval+ K*2*pi;
                end
            end
            for TrailTime = 1:size(Phi_matrix,3)
                %% smooth Continues phase
                PhaseProportion = Continues_Phi_matrix(:,:,TrailTime,trailsample)./(2*pi);
                clustervector = reshape(PhaseProportion,[numel(PhaseProportion),1]);
                clustervector(isnan(clustervector)) = [];
                [idx,c] = kmeans(clustervector,ceil(range(clustervector)));
                cluster_indx_matrix = zeros(1,numel(c));
                for i  = 1:numel(c)
                    cluster_indx_matrix(i) = ((sum(idx==i)/numel(idx)));
                end
                cluster_indx = find(cluster_indx_matrix ==max(cluster_indx_matrix));
                cluster_indx = cluster_indx(1);
                real_instnt_phase_mean = mean(clustervector(idx==cluster_indx));
                k = round(abs(PhaseProportion-real_instnt_phase_mean)+0.01);
                upsmooth = Continues_Phi_matrix(:,:,TrailTime,trailsample) - 2*pi*k.*(PhaseProportion-...
                    real_instnt_phase_mean>0.5);
                downsmooth = upsmooth + 2*pi*k.*(PhaseProportion-...
                    real_instnt_phase_mean<-0.5);
                Continues_Phi_matrix(:,:,TrailTime,trailsample) = downsmooth;
            end
        end
end
end