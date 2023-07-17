function  [Continues_Phi_matrix] = SmoothContinuesPhase(Phi_matrix)
Continues_Phi_matrix = zeros(size(Phi_matrix));
timesample = 1:size(Phi_matrix,3);

for i =  1:size(Phi_matrix,1)
    for j = 1:size(Phi_matrix,2)
        phase_interval = squeeze(Phi_matrix(i,j,:));
        K = FindPhaseCoeff(phase_interval,timesample);
        Continues_Phi_matrix(i,j,:) = phase_interval+ K*2*pi;
    end
end

% Define Continues phase
for TrailTime = 1:numel(timesample)
    
    PhaseProportion = Continues_Phi_matrix(:,:,TrailTime)./(2*pi);
    clustervector = reshape(PhaseProportion,[numel(PhaseProportion),1]);
    clustervector(isnan(clustervector)) = [];
    %....clustering technique................
%     [idx,c,sumd,D] = kmeans(clustervector,ceil(range(clustervector)));
%     cluster_indx_matrix = zeros(1,numel(c));
%     for i  = 1:numel(c)
%         cluster_indx_matrix(i) = ((sum(idx==i)/numel(idx)));
%     end
%     cluster_indx = find(cluster_indx_matrix ==max(cluster_indx_matrix));
%     cluster_indx = cluster_indx(1);
%     real_instnt_phase_mean = mean(clustervector(idx==cluster_indx));
%     real_instnt_phase_std = std(clustervector(idx==cluster_indx));
  %............Find the most repeated phase portion........
  real_instnt_phase_mean = mode(ceil(clustervector));
    k = round(abs(PhaseProportion-real_instnt_phase_mean)+0.01);
    a = Continues_Phi_matrix(:,:,TrailTime) - 2*pi*k.*(PhaseProportion-...
        real_instnt_phase_mean>0.5);
    b = a + 2*pi*k.*(PhaseProportion-...
        real_instnt_phase_mean<-0.5);
    Continues_Phi_matrix(:,:,TrailTime) = b;
end
