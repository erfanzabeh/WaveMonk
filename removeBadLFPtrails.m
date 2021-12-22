%% Dellet bad LFP chanels 
function ValidTrials = removeBadLFPtrails(event,TrailsSet,channel)
ValidTrials = [];
        for  i = [TrailsSet]
            if ~sum(event(i).bad_lfp_channels == channel)
                ValidTrials = [ValidTrials;i];
            end
        end
end