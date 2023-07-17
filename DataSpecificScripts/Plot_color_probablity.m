function Plot_color_probablity(Grand_Dir,Grand_PGD,trsch,epoch_index,Time,Freq,parameters)
[start_index, end_index,Time] = TimeInterval(epoch_index,Time);

shift{1,1} = 2;
shift{1,2} = -4;
shift{2,1} = 2;
shift{2,2} = -3.5;
shift{3,1} = 2;


shift{1,1} = 0;
shift{1,2} = -0;
shift{2,1} = 0;
shift{2,2} = -0;
shift{3,1} = 0;


for monkey_index = 1:2
    monkey_name = parameters.monkey_names{monkey_index};
    for Array = 1:2
        h= figure;
        scrsz = get(0,'ScreenSize');
        set(h, 'Position',scrsz);
        subplot(2,10,[1:10])
        onset = parameters.epoch_values{epoch_index};
        nbins = 72;
        
        PGD_Constrain = Grand_PGD{Array,monkey_index};
        Dir_Probablity_Matrix = zeros(nbins,size(Grand_Dir{Array,monkey_index},1)-1);
        for TrialTime  = 2:size(Grand_Dir{Array,monkey_index},1)
            WaveVar  = mod(Grand_Dir{Array,monkey_index}(TrialTime,PGD_Constrain(TrialTime,:)>trsch)+shift{Array,monkey_index},2*pi);
            [N,edges] = histcounts(WaveVar,nbins,'Normalization','pdf');
            Dir_Probablity_Matrix(:,TrialTime-1) = N;
        end
        
        K = 0.125*ones(3);
Zsmooth1 = conv2(Dir_Probablity_Matrix,K,'same')
        imagesc(Zsmooth1)
        title('Propagation Direction Distribution Along Time')
        
        ylabel('Relative Direction Propation')
        xlabel('Time from Cue onset')
        c = colorbar;
        c.Label.String = 'Probability';
        colormap jet
        %             caxis([0 .4])
        ax = gca;
        
        TimePoints = [ -0.8, -0.5, -0.2, 0, 0.2, 0.8, 1 , 1.2];
        ax.XTick = find((abs(Time - TimePoints(1))<1e-5) | (abs(Time - TimePoints(2))<1e-5)| (abs(Time - TimePoints(3))<1e-5)...
            | (abs(Time - TimePoints(4))<1e-5) | (abs(Time - TimePoints(5))<1e-5) | (abs(Time - TimePoints(6))<1e-5)|...
            (abs(Time - TimePoints(7))<1e-5)| (abs(Time - TimePoints(8))<1e-5))- start_index+1;
        ax.XTickLabel = Time(ax.XTick+ start_index-1);
        ax.YTickLabel = ax.YTick.*5;
        
        hold on
        
        TimingLabels(epoch_index,Time,parameters)
        title({['Propagation Direction Distribution Along Time'];...
            [monkey_name,' Array',num2str(Array-1*(Array==3))]})
        hold off
        
        
        
        
        
        for i = 1:10
            subplot(2,10,[10+i])
            %generate some dummy data
            A = [];
%           A = Grand_Dir{Array,monkey_index}((i-1)*64+1:i*64,:);
            A = Grand_Dir{Array,monkey_index}(i*64,Grand_PGD{Array,monkey_index}(i*64,:)>trsch);
            A = mod(A,2*pi);
%           A = mod(reshape(A,[1,numel(A)])-pi/2+shift{Array,monkey_index},2*pi);
            %display the rose
            h = polarhistogram(A,nbins/3,'Normalization','pdf');
%            h.DisplayStyle = 'stairs';
%            title([num2str(Time((i-1)*64+1)),':',num2str(Time(i*64+1)),'ms'])
            title([num2str(Time(i*64-1)),'ms'])
        end
        
        save2pdf(['Dir_Target ',monkey_name,' Array',num2str(Array)])
    end
    
    
    
    
    % axes
    %
    % text(0.15,1.15,[' Anterior'],'FontSize',18)
    % text(0.8,1.15,[' Posterior'],'FontSize',18)
    %
    %
    % text(0.15,.5,[' Anterior'],'FontSize',18)
    % text(0.8,.5,[' Posterior'],'FontSize',18)
    %
    % h = text(-0.1,0.85,['McDuff'],'FontSize',18);
    % set(h,'Rotation',90);
    %
    % h = text(-0.1,0.1,['Mojo'],'FontSize',18);
    % set(h,'Rotation',90);
    % axis off
    %     save2pdf(['Dir_Target'])
end
