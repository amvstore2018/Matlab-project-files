clc
clear all
close all
mkdir ('Motors Data (Load Cell)')
mkdir ('Motors Figures (Load Cell)')
for i = 1 : 4
    mkdir ('Motors Data (Load Cell)',['Motor ',num2str(i)])
    mkdir ('Motors Figures (Load Cell)',['Motor ',num2str(i)])
    file = ['Motor ',num2str(i),'.xlsx'];
    motor = readtable(file);
    RimFire = readtable(file);
    RimFirePWMf = table2array(RimFire(:,1));
    RimFireThrustf = table2array(RimFire(:,2));
    RimFirePWMb = table2array(RimFire(:,3));
RimFireThrustb = table2array(RimFire(:,4));
    n = 1;
    Number = 0.1;%percentage of length
    for k=1530:10:max(RimFirePWMf)
        i1{n} = find(RimFirePWMf == k);
        PWMf(n) = k;
        Tf(n) = mean(RimFireThrustf(i1{n}(end-ceil(Number*length(i1{n})):end)));
        errf(n) = max(RimFireThrustf(i1{n}(end-ceil(Number*length(i1{n})):end)))-min(RimFireThrustf(i1{n}(end-ceil(Number*length(i1{n})):end)));
        
        n=n+1;
    end
    n=1;
    for k=max(RimFirePWMb):-10:1530
        i1{n} = find(RimFirePWMb == k);
        PWMb(n) = k;
        Tb(n) = mean(RimFireThrustb(i1{n}(end-ceil(Number*length(i1{n})):end)));
        errb(n) = max(RimFireThrustb(i1{n}(end-ceil(Number*length(i1{n})):end)))-min(RimFireThrustb(i1{n}(end-ceil(Number*length(i1{n})):end)));
        
        n=n+1;
    end
    
    %% Plots
    g=9.81;
    figure
    set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    subplot(1,2,1)
    errorbar(PWMf,-Tf/1000*g,errf,'lineWidth',1.5)
    grid on;box on;
    xlabel('PWM','FontSize',13,'FontWeight','bold');
    ylabel('Thrust (N)','FontSize',13,'FontWeight','bold');
    title(['Motor ',num2str(i),' (Forward)'],'FontSize',16,'FontWeight','bold');
    set(gca,'FontSize',14);
    subplot(1,2,2)
    errorbar(PWMb,-Tb/1000*g,errb,'lineWidth',1.5)
    grid on;box on;
    xlabel('PWM','FontSize',13,'FontWeight','bold');
    ylabel('Thrust (N)','FontSize',13,'FontWeight','bold');
    title(['Motor ',num2str(i),' (Backward)'],'FontSize',16,'FontWeight','bold');
    set(gca,'FontSize',14);
    saveas(gcf,  fullfile(['Motors Figures (Load Cell)\Motor ',num2str(i)],'1.eps'),'epsc');
    
    NomThrust=1650;
    n=4;
    PWM_ = PWMf(find(PWMf == NomThrust)-n:find(PWMf == NomThrust)+n);
    Fz_ = Tf(find(PWMf == NomThrust)-n:find(PWMf == NomThrust)+n)*-g/1000;
    K = mean(diff(Fz_)./diff(PWM_));
    fid1 = fopen( fullfile(['Motors Data (Load Cell)\Motor ',num2str(i)], [num2str(NomThrust),'.txt']), 'wt' );
    fprintf(fid1,'%s',evalc('K'));
    fclose(fid1);
    NomThrust=1700;
    n=4;
    PWM_ = PWMf(find(PWMf == NomThrust)-n:find(PWMf == NomThrust)+n);
    Fz_ = Tf(find(PWMf == NomThrust)-n:find(PWMf == NomThrust)+n)*-g/1000;
    K = mean(diff(Fz_)./diff(PWM_));
    fid1 = fopen( fullfile(['Motors Data (Load Cell)\Motor ',num2str(i)], [num2str(NomThrust),'.txt']), 'wt' );
    fprintf(fid1,'%s',evalc('K'));
    fclose(fid1);
end