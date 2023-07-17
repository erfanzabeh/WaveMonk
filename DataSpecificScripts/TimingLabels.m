function TimingLabels(epoch_index,Time,parameters) 

[start_index, end_index,Time] = TimeInterval(epoch_index,Time);
onset = parameters.epoch_values{epoch_index};
hold on         


if strcmp(onset,'reward')
        TimeFlag = [-0.380,0];  
        
        plot(zeros(1,74)+ find((abs(Time - TimeFlag(1))<1e-5))- start_index+1, [0:73],'k');
        h1=text(find((abs(Time - TimeFlag(1))<1e-5))- start_index-8,29,' Target acquire');
        h1.FontSize = 8;
        h1.FontWeight = 'bold';
        set(h1,'Rotation',90);
        
        plot(zeros(1,74)+ find((abs(Time - TimeFlag(2))<1e-5))- start_index+1, [0:73],'k','LineWidth',2);
        
        h1=text(find((abs(Time - TimeFlag(2))<1e-5))- start_index - 8,27,' Reward on');
        h1.FontSize = 8;
        h1.FontWeight = 'bold';
        set(h1,'Rotation',90);
         
else
            
        TimeFlag = [0,0.835, 1.06];
        
        plot(zeros(1,74)+ find(Time == TimeFlag(1))- start_index+1, [0:73],'Color',[0 0 0],'LineWidth',2);
%         h1=text(find(Time == TimeFlag(1))- start_index-8,27,' Cue on');
%         h1.FontSize = 8;
%         h1.FontWeight = 'bold';
%         set(h1,'Rotation',90);
        hold on 
        
        plot(zeros(1,74)+ find((abs(Time - TimeFlag(2))<1e-5))- start_index+1, [0:73],'k','LineWidth',2);
%         h1=text(find((abs(Time - TimeFlag(2))<1e-5))- start_index - 8,27,' Target on');
%         h1.FontSize = 8;
%         h1.FontWeight = 'bold';
%         set(h1,'Rotation',90);
        
        plot(zeros(1,74)+ find((abs(Time - TimeFlag(3))<1e-5))- start_index+1, [0:73],'m','LineWidth',2);
%         h1=text(find((abs(Time - TimeFlag(3))<1e-5))- start_index-8,29,' Target acquire');
%         h1.FontSize = 8;
%         h1.FontWeight = 'bold';
%         set(h1,'Rotation',90);
end
end
