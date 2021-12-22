function Continues_Phi_matrix = Periodic2ContinuesPhase(Phi_matrix)

 Continues_Phi_matrix = NaN(size(Phi_matrix));
 
for trailsample = 1:size(Phi_matrix,4)
    for TrailTime = 1:size(Phi_matrix,3)
        %% Define Continues phase
        for i =  1:size(Phi_matrix,1)
            for j = 1:size(Phi_matrix,2)
                pk = findpeaks(squeeze(Phi_matrix(i,j,1:TrailTime,trailsample)));
                if ~isempty(pk.loc)
                    K = numel(pk.loc)- (pk.loc(end)==TrailTime);
                else
                    K = numel(pk.loc)- 1;
                end
                Continues_Phi_matrix(i,j,TrailTime,trailsample) = Phi_matrix(i,j,TrailTime,trailsample)+ K*2*pi ;
            end
        end
    end
end